//
//  UtilsTest.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 16/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class UtilsTest: XCTestCase {

    func testThatUtilsLoadsData() {
        do {
            let data = try Utils.loadData(resource: "data", extension: "json")
            XCTAssert(data.count > 0, "Empty data loaded")
        } catch {
            XCTFail(error.localizedDescription)
        }

    }

}
