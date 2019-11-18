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
    let apiWorker: UsageAPIWorkerProtocol = UsageAPIWorker()
    let mappingWorker: UsageMappingWorker = UsageMappingWorker()

    private var records = [Models.UsageRecord]()

    private var isLoading = false {
        didSet {
            if isLoading {
                output?.showLoading()
            } else {
                output?.hideLoading()
            }
        }
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
            output?.showAlert(title: "Error", message: error.localizedDescription)
            isLoading = false
        }

    }

    private func resultsCompletionHandler(response: Models.UsageResponse?, error: Error?) {
        if let response = response {
            do {
                let records = try mappingWorker.records(from: response.result)
                self.records.append(contentsOf: records)
                let sortedRecords = sort(records: self.records)
                self.records = sortedRecords.flatMap { $0 }
                output?.present(records: sortedRecords)
            } catch {
                output?.showAlert(title: "Error", message: error.localizedDescription)
            }
        } else {
            output?.showAlert(title: "Error", message: error?.localizedDescription ?? "No response from api")
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

        // for decideding decrease over previous quarter
        var previousRecord: Models.UsageRecord? = nil

        sortedRecords.forEach { (record) in
            var record = record
            if let previousRecord = previousRecord {
                if let dataVolume = record.volumeOfData?.numericValue, let previousDataVolume = previousRecord.volumeOfData?.numericValue,
                    dataVolume > previousDataVolume /* ordered in descending quarter*/ {
                    record.isDecreaseOverQuarter = true
                }
            }
            var recordsArray: [Models.UsageRecord]
            if record.date?.year == separatedRecords.last?.last?.date?.year {
                recordsArray = separatedRecords.popLast() ?? []
            } else {
                recordsArray = []
            }
            recordsArray.append(record)
            separatedRecords.append(recordsArray)
            previousRecord = record
        }
        return separatedRecords
    }
}
