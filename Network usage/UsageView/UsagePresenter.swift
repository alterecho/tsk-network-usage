//
//  UsagePresenter.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsagePresenter: UsagePresenterInputProtocol {

    weak var output: UsagePresenterOutputProtocol?

    func present(records: [Models.UsageRecord]) {
        let vm = UsageViewVM(records: records)
        output?.update(vm: vm)
    }
    
}
