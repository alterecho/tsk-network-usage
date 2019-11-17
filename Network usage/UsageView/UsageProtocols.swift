//
//  UsageView.swift
//  Network Usage
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

protocol UsageInteractorInputProtocol: class {
    var output: UsagePresenterInputProtocol? { get set }
    func load()
    func reachedEndOfPage()
}

protocol UsagePresenterInputProtocol: class {
    var output: UsagePresenterOutputProtocol? { get set }
    func present(records: [Models.UsageRecord])
    func showAlert(title: String, message: String)
}

protocol UsagePresenterOutputProtocol: class {
    func update(vm: UsageViewVM)
    func showAlert(title: String, message: String)
}

protocol UsageAPIWorkerProtocol {
    func fetchUsageData(resourceID: String, limit: Int, completionHandler: @escaping (Models.UsageResponse?, Error?) -> ()) throws
}

protocol UsageMappingWorkerProtocol {
    func records(from response: Models.UsageResponse.Result) throws -> [Models.UsageRecord]
}


