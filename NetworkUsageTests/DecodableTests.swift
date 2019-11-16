//
//  DecodableTests.swift
//  Network UsageTests
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class DecodableTests: NetworkUsageTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsageResponseDecodable() {
        do {
            let data = try mockUsageResponseData()
            let usageResponse = try JSONDecoder().decode(Models.UsageResponse.self, from: data)
            print(usageResponse)
        } catch {
            print(error)
            XCTFail(error.localizedDescription)
            return
        }
    }
}
