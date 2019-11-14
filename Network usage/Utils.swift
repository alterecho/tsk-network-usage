//
//  Utils.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 14/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

/// helper methods
class Utils {
    static func loadData(resource: String, extension ext: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: resource, withExtension: ext) else {
            throw Errors.fileNotFound("\(resource).\(ext) not found")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw Errors.invalidData
        }

        return data
    }


}
