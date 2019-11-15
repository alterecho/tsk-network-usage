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

        var records = [Models.UsageRecord]()
        let recordsInResponse = response.records
        recordsInResponse.forEach { (respRecord: Models.UsageResponse.Result.Record) in

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
