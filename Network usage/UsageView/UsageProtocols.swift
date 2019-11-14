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

protocol UsagePresenterInputProtocol {
    var output: UsagePresenterOutputProtocol? { get set }
    func present(records: [Models.UsageRecord])
}

protocol UsagePresenterOutputProtocol: class {
    func update(vm: UsageViewVM)
}

protocol UsageAPIWorkerProtocol {
    func fetchUsageData(completion: (Models.UsageResponse.Result?, Error?) -> ())
}

protocol UsageMappingWorkerProtocol {
    func records(from response: Models.UsageResponse.Result) -> [Models.UsageRecord]
}


