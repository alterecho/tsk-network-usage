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

    func load() {
        apiWorker.fetchUsageData { [weak self] (response: Models.UsageResponse?, error: Error?) in
            if let response = response {
                do {
                    if let records = try self?.mappingWorker.records(from: response.result) {
                        print(records)
                    } else {
                        self?.output?.showAlert(title: "Error", message: error?.localizedDescription ?? "Unable to map records")
                    }
                } catch {
                    self?.output?.showAlert(title: "Error", message: error.localizedDescription)
                }


            } else {
                self?.output?.showAlert(title: "Error", message: error?.localizedDescription ?? "No response from api")
            }
        }
    }

    func reachedEndOfPage() {
    }
}
