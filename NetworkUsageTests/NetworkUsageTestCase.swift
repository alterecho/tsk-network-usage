//
//  NetworkUsageTestCase.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 16/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class NetworkUsageTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func mockUsageResponseData() throws -> Data {
        let fileName = "data", ext = "json"
        guard let url = Bundle.main.url(forResource: fileName, withExtension: ext) else {
            throw Errors.fileNotFound("\(fileName).\(ext) not found")
        }
        guard let data = try? Data(contentsOf: url) else {
            throw Errors.invalidData
        }

        return data
    }

    func mockUsageResponse() throws -> Models.UsageResponse {
        let data = try mockUsageResponseData()
        return try JSONDecoder().decode(Models.UsageResponse.self, from: data)
    }

}
