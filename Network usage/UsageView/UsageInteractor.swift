//
//  UsageInteractor.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsageInteractor: UsageInteractorInputProtocol {
    var output: UsagePresenterInputProtocol?
    let apiWorker: UsageAPIWorkerProtocol
    let cacheWorker: UsageCacheWorkerProtocol
    let mappingWorker: UsageMappingWorker

    /// the records that are accumulated and is being displayed
    private var records = [Models.UsageRecord]()
    /// used to clear the records property on successful fetch
    private var isDisplayingCachedData = false

    private var isLoading = false {
        didSet {
            if isLoading {
                output?.showLoading()
            } else {
                output?.hideLoading()
            }
        }
    }

    init(apiWorker: UsageAPIWorkerProtocol = UsageAPIWorker(), cacheWorker: UsageCacheWorkerProtocol = UsageCacheWorker(),  mappingWorker: UsageMappingWorker = UsageMappingWorker()) {
        self.apiWorker = apiWorker
        self.cacheWorker = cacheWorker
        self.mappingWorker = mappingWorker
    }
    
    func load() {
        fetchData()
    }

    func reachedEndOfPage() {
        if isLoading {
            return
        }
        fetchData()
    }

    private func fetchData() {
        isLoading = true
        do {
            try apiWorker.fetchUsageData { [weak self] (response: Models.UsageResponse?, error: Error?) in
                self?.resultsCompletionHandler(response: response, error: error)
                self?.isLoading = false
            }
        } catch {
            output?.showAlert(title: Strings.ERROR_TITLE, message: error.localizedDescription)
            isLoading = false
        }

    }

    /// handles response from API
    private func resultsCompletionHandler(response: Models.UsageResponse?, error: Error?) {
        if let error = error {
            output?.showAlert(title: Strings.ERROR_TITLE, message: error.localizedDescription)
            if records.count == 0 {
                loadFromCache()
            }
        } else if let response = response {
            // if no records, show alert
            if response.result.records.count == 0 {
                output?.showAlert(title: Strings.NO_MORE_RECORDS_TITLE, message: Strings.NO_MORE_RECORDS_MSG)
            } else {
                do {
                    let records = try mappingWorker.records(from: response.result)

                    // clear existing records array if it is cached data. to prevent mixing of cached data
                    if isDisplayingCachedData {
                        self.records = []
                        isDisplayingCachedData = false
                    }
                    self.records.append(contentsOf: records)
                    let sortedRecords = sort(records: self.records)
                    self.records = sortedRecords.flatMap { $0 }
                    output?.present(records: sortedRecords)

                    // cache the accumulated records, since response and parse is success
                    // clear existing cache first
                    try cacheWorker.clearCache()
                    try? cacheWorker.cache(records: self.records)
                } catch {
                    output?.showAlert(title: Strings.ERROR_TITLE, message: error.localizedDescription)
                    if records.count == 0 {
                        loadFromCache()
                    }
                }
            }
        } else {
            if records.count == 0 {
                loadFromCache()
            }
        }
    }

    /// loads UsageRecords from cache and sets the records property
    private func loadFromCache() {
        if let cachedRecords = cacheWorker.loadCachedRecords() {
            self.records = cachedRecords
            let sortedRecords = sort(records: self.records)
            self.records = sortedRecords.flatMap { $0 }
            isDisplayingCachedData = true
            output?.present(records: sortedRecords)
        }
    }

    /// returns 2D array  of  arrays of UsageRecord objects. Each array sorted according to year
    /// - Parameter records: UsageRecord objects to be sorted
    func sort(records: [Models.UsageRecord]) -> [[Models.UsageRecord]] {
        let sortedRecords = records.sorted { (record1, record2) in
            if record1.date?.year == record2.date?.year {
                return (record1.date?.quarter ?? 0) > (record2.date?.quarter ?? 0)
            }
            return (record1.date?.year ?? 0) > (record2.date?.year ?? 0)
        }
        var separatedRecords = [[Models.UsageRecord]]()


        for i in 0..<sortedRecords.count {
            var record = sortedRecords[i]

            // decide decrease over previous quarter
            let nextIndex = i + 1
            let nextRecord: Models.UsageRecord? = nextIndex < sortedRecords.count ? sortedRecords[nextIndex] : nil
            if let dataVolume = record.volumeOfData, let nextDataVolume = nextRecord?.volumeOfData,
                dataVolume < nextDataVolume /* ordered in descending quarter*/ {
                record.isDecreaseOverQuarter = true
            }

            // if it's a new year, create a new array of records for the next set of records (table section)
            var recordsArray: [Models.UsageRecord]
            if record.date?.year == separatedRecords.last?.last?.date?.year {
                recordsArray = separatedRecords.popLast() ?? []
            } else {
                recordsArray = []
            }
            recordsArray.append(record)
            separatedRecords.append(recordsArray)
        }

        return separatedRecords
    }
}
