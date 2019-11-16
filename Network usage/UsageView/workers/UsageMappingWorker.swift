//
//  UsageMappingWorker.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsageMappingWorker: UsageMappingWorkerProtocol {
    func records(from response: Models.UsageResponse.Result) throws -> [Models.UsageRecord] {
//        let fieldsInResponse = response.fields

        // records to return
        var records = [Models.UsageRecord]()

        // [[String : AnyValue]] mapped to [[ID : AnyValue]]
        let convertedResponseRecords = try convert(responseRecords: response.records, fields: response.fields)

        convertedResponseRecords.forEach { dict in
            /// add record only if it has an ID ("_id")
            if let id = dict[.id] {
                let record = Models.UsageRecord(volumeOfData: dict[Models.UsageResponse.ID.dataVolume],
                                                year: nil,
                                                quarter: nil,
                                                id: id)
                records.append(record)
            }

        }

        return records
    }

    private func convert(value: Models.AnyValue, to type: Models.UsageResponse.DataType) throws -> Models.AnyValue {
        switch type {
        case .int4:
            switch value {
            case .int4:
                return value
            case .numeric(let numericValue):
                return .int4(Int(numericValue))
            case .string(let strValue):
                if let int = Int(strValue) {
                    return .int4(int)
                } else {
                    throw Errors.conversionError("unable to convert \(strValue) to Int")
                }
            }
        case .text:
            switch value {
            case .int4(let int):
                return .string(String(int))
            case .numeric(let numericValue):
                return .string(String(numericValue))
            case .string(let strValue):
                return .string(strValue)
            }
        case .numeric:
            switch value {
            case .int4(let int):
                return .numeric(Double(int))
            case .numeric(let numericValue):
                return .numeric(numericValue)
            case .string(let strValue):
                if let double = Double(strValue) {
                    return .numeric(double)
                } else {
                    throw Errors.conversionError("unable to convert \(strValue) to Double")
                }

            }
        }
    }

    private func convert(responseRecords: [[String : Models.AnyValue]], fields: [Models.UsageResponse.Result.Field])
        throws -> [[Models.UsageResponse.ID : Models.AnyValue]]
    {
        return try responseRecords.map { dict -> [Models.UsageResponse.ID : Models.AnyValue] in
            var newDict = [Models.UsageResponse.ID : Models.AnyValue]()
            try dict.forEach { entry in


                if let id = Models.UsageResponse.ID(rawValue: entry.key) {
                    if let field = fields.first(where: { $0.id == id }) {
                        do {
                            newDict[id] = try convert(value: entry.value, to: field.type)
                        } catch {
                            throw error
                        }
                    }

                }
            }
            return newDict
        }

    }
}
