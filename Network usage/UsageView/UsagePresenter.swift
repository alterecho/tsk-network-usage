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

    func present(records: [[Models.UsageRecord]]) {
        var sections = [UsageTableViewCellVM.Section]()
        records.forEach { (recordsArray) in
            let cellVMs: [UsageTableViewCellVM] = recordsArray.map { (record) in
                let cellVM = UsageTableViewCellVM(
                    dataVolume: "\(record.volumeOfData?.stringValue ?? "0")",
                    quarter: "Q\(record.date?.quarter ?? 1)",
                    isDecreaseOverPreviousQuarter: record.isDecreaseOverQuarter
                )
                return cellVM
            }
            let sectionTitle: String?
            if let year = recordsArray.first?.date?.year {
                sectionTitle = "\(year)"
            } else {
                sectionTitle = nil
            }
            let section = UsageTableViewCellVM.Section(title: sectionTitle, vms: cellVMs)
            sections.append(section)
        }
        let vm = UsageViewVM(title: "Network data volume", tableSections: sections)
        output?.update(vm: vm)
    }

    func showAlert(title: String, message: String) {
        output?.showAlert(title: title, message: message)
    }

    func showLoading() {
        output?.showLoading()
    }

    func hideLoading() {
            output?.hideLoading()
    }
}
