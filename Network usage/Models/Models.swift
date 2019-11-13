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
        case int8(Int8)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let val = try? container.decode(Int8.self) {
                self = .int8(val)
            } else if let val = try? container.decode(String.self) {
                self = .string(val)
            } else {
                throw Errors.decodeError("Unknown type")
            }
        }
    }

    enum Quarter {
        case q1, q2, q3, q4
    }

    struct UsageRecord {
        let volumeOfData: String
        let year: String
        let quarter: Quarter
        let id: Int
    }

}


