//
//  UsageMappingWorker.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsageMappingWorker: UsageMappingWorkerProtocol {
    func records(from response: Models.UsageResponse.Result) -> [Models.UsageRecord] {
//        let fieldsInResponse = response.fields
        let recordsInResponse = response.records
        var records = [Models.UsageRecord]()
        recordsInResponse.forEach { (respRecord: [Models.UsageResponse.ID: Models.AnyValue]) in

            if let id = respRecord[.id] {
                let record = Models.UsageRecord(volumeOfData: respRecord[Models.UsageResponse.ID.dataVolume],
                                                year: nil,
                                                quarter: nil,
                                                id: id)
                records.append(record)
            }

        }

        return records
    }
}
