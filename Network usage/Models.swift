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
                if let url = URL(string: URLs.base + urlStr) {
                    start = url
                } else {
                    throw Errors.decodeError("next decode error")
                }
                urlStr = try container.decode(String.self, forKey: .next)

                if let url = URL(string: URLs.base + urlStr) {
                    next = url
                } else {
                    throw Errors.decodeError("start decode error")
                }
            }
        }

        let resourceID: String
        let fields: [[String : String]]
        let records: [[String : String]]
        let links: PageLinks
        let limit: Int
        let total: Int
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


