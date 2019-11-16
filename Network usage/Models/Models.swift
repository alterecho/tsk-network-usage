//
//  Models.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

enum Models {

    enum AnyValue: Decodable {
        case string(String)
        case int4(Int)
        case numeric(Double)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let val = try? container.decode(Int.self) {
                self = .int4(val)
            } else if let val = try? container.decode(String.self) {
                self = .string(val)
            } else if let val = try? container.decode(Double.self) {
                self = .numeric(val)
            } else {
                throw Errors.decodeError("Unknown type")
            }
        }

//        var stringValue: String {
//            switch self {
//            case .string(let value):
//                return value
//            case .int4(let value):
//                return String(value)
//            case .numeric(let value):
//                return String(value)
//            }
//        }
//
//        var numericValue: Double? {
//            switch self {
//            case .string(let value):
//                return Double(value)
//            case .int4(let value):
//                return Double(value)
//            case .numeric(let value):
//                return value
//            }
//        }
    }

    struct Date {
        let quarter: Int
        let year: Int
        init(string: String) throws {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-QQQ"

            guard let date = formatter.date(from: string) else {
                throw Errors.decodeError("Unable to decode date from string \(string)")
            }
            formatter.dateFormat = "Q"
            guard let quarter = Int(formatter.string(from: date)) else {
                throw Errors.decodeError("Unable to parse quarter from \(string)")
            }
            year = Calendar.current.component(.year, from: date)
            self.quarter = quarter
        }

        init(value: Models.AnyValue) throws {
            switch value {
            case .string(let str):
                try self.init(string: str)
            default:
                throw Errors.decodeError("Unable to init Date from \(value)")
            }
        }
    }

    struct UsageRecord {
        let volumeOfData: AnyValue?
        let date: Date?
        let id: AnyValue
    }

}


