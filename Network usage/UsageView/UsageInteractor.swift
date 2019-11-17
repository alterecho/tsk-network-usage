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

    private var resourceID = URLStrings.startResourceID
    private var recordsPerPage = 10
    private var currentPage = 1

    func load() {
        fetchData()
    }

    func reachedEndOfPage() {
    }

    private func fetchData() {
        do {
            try apiWorker.fetchUsageData(resourceID: resourceID, limit: recordsPerPage) { [weak self] (response: Models.UsageResponse?, error: Error?) in
                self?.resultsCompletionHandler(response: response, error: error)
            }
        } catch {
            output?.showAlert(title: "Error", message: error.localizedDescription)
        }

    }

    private func resultsCompletionHandler(response: Models.UsageResponse?, error: Error?) {
        if let response = response {
            do {
                let records = try mappingWorker.records(from: response.result)
                print(records)
            } catch {
                output?.showAlert(title: "Error", message: error.localizedDescription)
            }
        } else {
            output?.showAlert(title: "Error", message: error?.localizedDescription ?? "No response from api")
        }
    }
}
