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

    private var startResourceID = URLStrings.startResourceID
    private var nextResourceID = URLStrings.startResourceID
    private var recordsPerPage = 10
    private var currentPage = 1
    
    func load() {
        fetchData()
    }

    func reachedEndOfPage() {
    }

    private func fetchData() {
        do {
            try apiWorker.fetchUsageData(resourceID: nextResourceID, limit: recordsPerPage) { [weak self] (response: Models.UsageResponse?, error: Error?) in
                self?.resultsCompletionHandler(response: response, error: error)
            }
        } catch {
            output?.showAlert(title: "Error", message: error.localizedDescription)
        }

    }

    private func resultsCompletionHandler(response: Models.UsageResponse?, error: Error?) {
        if let response = response {
//            startResourceID = response.result.links.start
//            nextResourceID = response.result.links.next
            do {
                let records = try mappingWorker.records(from: response.result)
                let sortedRecords = sort(records: records)
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
                    dataVolume < previousDataVolume {
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
