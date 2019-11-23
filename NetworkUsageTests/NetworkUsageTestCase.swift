//
//  NetworkUsageTestCase.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 16/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage


/// class that is subclassed by some tests
class NetworkUsageTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func mockUsageResponseData() throws -> Data {
        return try Utils.loadData(resource: "data", extension: "json")
    }

    func mockUsageResponse() throws -> Models.UsageResponse {
        let data = try mockUsageResponseData()
        return try JSONDecoder().decode(Models.UsageResponse.self, from: data)
    }

}
