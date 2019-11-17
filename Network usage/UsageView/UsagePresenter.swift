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
        var cellVMs = [UsageTableViewCellVM]()
        records.forEach { (record) in
            let cellVM = UsageTableViewCellVM(dataVolume: "\(record.volumeOfData?.stringValue ?? "0")")
            cellVMs.append(cellVM)
        }
        let vm = UsageViewVM(cellVMs: cellVMs)
        output?.update(vm: vm)
    }

    func showAlert(title: String, message: String) {
        output?.showAlert(title: title, message: message)
    }
    
}
