//
//  UsageViewModels.swift
//  Network Usage
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

extension Models {

    struct UsageResponse: Decodable {

        enum DataType: String, Decodable {
            case int4
            case text
            case numeric


        }

        /// Known IDs / key types in the fields of the API response
        enum ID: String, Decodable {
            case id = "_id"
            case quarter
            case dataVolume = "volume_of_mobile_data"

            init(from decoder: Decoder) throws {
                do {
                    let container = try decoder.singleValueContainer()
                    let string = try container.decode(String.self)
                    if let id = ID(rawValue: string) {
                        self = id
                    } else {
                        throw Errors.decodeError("unable to init ID with rawValue \(string)")
                    }
                } catch {
                    throw error
                }
            }
        }

        struct Result: Decodable {
            
            struct Field: Decodable {
                let type: DataType
                let id: ID
            }

            struct PageLinks: Decodable {
                let start: URL
                let next: URL

                enum CodingKeys: String, CodingKey {
                    case start, next
                }

                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
//                    var urlStr = try container.decode(String.self, forKey: .next)
                    start = try container.decode(URL.self, forKey: .start)
//                    urlStr = try container.decode(String.self, forKey: .next)
                    next = try container.decode(URL.self, forKey: .next)
                }
            }

            let resourceID: String
            let fields: [Field]
            let records: [[String : AnyValue]]
            let links: PageLinks
            let limit: Int
            let total: Int?

            enum CodingKeys: String, CodingKey {
                case resourceID = "resource_id"
                case fields
                case records
                case links = "_links"
                case limit
                case total
            }

            init(from decoder: Decoder) throws {
                do {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    resourceID = try container.decode(String.self, forKey: .resourceID)
                    self.fields = try container.decode([Field].self, forKey: .fields)
                    self.records = try container.decode([[String : AnyValue]].self, forKey: .records)
                    links = try container.decode(PageLinks.self, forKey: .links)
                    limit = try container.decode(Int.self, forKey: .limit)
                    total = try container.decodeIfPresent(Int.self, forKey: .total)
                } catch {
                    throw error
                }
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
}

