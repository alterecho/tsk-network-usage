//
//  DecodableTests.swift
//  Network UsageTests
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class DecodableTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsageResponseDecodable() throws {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            XCTFail("sample not found")
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            XCTFail("data load error")
            return
        }


        let usageResponse: Models.UsageResponse

        do {
            usageResponse = try JSONDecoder().decode(Models.UsageResponse.self, from: data)
        } catch {
            XCTFail(error.localizedDescription)
            return
        }

    }

}
