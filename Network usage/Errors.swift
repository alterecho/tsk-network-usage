//
//  Errors.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

enum Errors: Error {
    case decodeError(String)
    case fileNotFound(String)
    case invalidData
    case conversionError(String)
    case invalidURL(String)
    case URLnotFound(String)
    case generic(String)
}
