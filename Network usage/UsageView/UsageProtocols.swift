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
    func present(records: [[Models.UsageRecord]])
    func showAlert(title: String, message: String)
    func showLoading()
    func hideLoading()
}

protocol UsagePresenterOutputProtocol: class {
    func update(vm: UsageViewVM)
    func showAlert(title: String, message: String)
    func showLoading()
    func hideLoading()
}

protocol UsageAPIWorkerProtocol {
    /// change the lnumber of items to be retrieved if required
    var limit: Int { get set }
    /// change the data offset if required
    var offset: Int { get set }
    /// change the resourceID if required
    var resourceID: String? { get set }

    func fetchUsageData(completionHandler: @escaping (Models.UsageResponse?, Error?) -> ()) throws
}

protocol UsageMappingWorkerProtocol {
    func records(from response: Models.UsageResponse.Result) throws -> [Models.UsageRecord]
}

protocol UsageCacheWorkerProtocol {
    func cache(records: [Models.UsageRecord]) throws
    func loadCachedRecords() -> [Models.UsageRecord]?
    func clearCache() throws
}


