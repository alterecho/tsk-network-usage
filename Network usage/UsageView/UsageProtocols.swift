//
//  UsageView.swift
//  Network Usage
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

protocol UsageInteractorInputProtocol {
    func load()
    func reachedEndOfPage()
}

protocol UsageInteractorOutputProtocol {
    func display()
}

protocol UsagePresenterOutputProtocol {
    func update()
}

protocol UsageAPIWorkerProtocol {
    func fetchUsageData(completion: (Models.UsageResponse.Result?, Error?) -> ())
}


