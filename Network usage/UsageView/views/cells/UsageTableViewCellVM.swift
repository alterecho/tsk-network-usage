//
//  UsageTableViewCellVM.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 17/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation



struct UsageTableViewCellVM {
    struct Section {
        let title: String?
        var vms: [UsageTableViewCellVM]
    }

    let dataVolume: String
    let quarter: String
    let isDecreaseOverPreviousQuarter: Bool
}
