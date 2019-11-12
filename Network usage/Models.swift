//
//  UsageViewModels.swift
//  Network Usage
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

enum Errors: Error {
    case decodeError(String)
}

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

struct UsageResponse: Decodable {

    struct Result: Decodable {
        struct Field: Decodable {
            let type: String
            let id: String
        }

        struct Record: Decodable {
            let type: String
            let id: String
        }

        struct PageLinks: Decodable {
            let start: URL
            let next: URL

            enum CodingKeys: String, CodingKey {
                case start, next
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                var urlStr = try container.decode(String.self, forKey: .next)
                start = URLs.base.appendingPathComponent(urlStr)
                urlStr = try container.decode(String.self, forKey: .next)
                next = URLs.base.appendingPathComponent(urlStr)
            }
        }

        let resourceID: String
        let fields: [[String : String]]
        let records: [[String : AnyValue]]
        let links: PageLinks
        let limit: Int
        let total: Int

        enum CodingKeys: String, CodingKey {
            case resourceID = "resource_id"
            case fields
            case records
            case links = "_links"
            case limit
            case total
        }
    }
    
    let help: URL
    let success: Bool
    let result: UsageResponse.Result

    enum CodingKeys: String, CodingKey {
        case help
        case success
        case result
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let helpString = try container.decode(String.self, forKey: .help)
        if let help = URL(string: helpString) {
            self.help = help
        } else {
            throw Errors.decodeError("Unable to decode 'help'")
        }
        success = try container.decode(Bool.self, forKey: .success)
        result = try container.decode(UsageResponse.Result.self, forKey: .result)
    }
}


