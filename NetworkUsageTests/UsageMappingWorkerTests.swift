//
//  UsageMappingWorkerTests.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 16/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class UsageMappingWorkerTests: NetworkUsageTestCase {

    var mappingWorker: UsageMappingWorker?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mappingWorker = UsageMappingWorker()
    }

    func testCreatingRecordsFromResponse() {
        let mappingWorker = self.mappingWorker ?? UsageMappingWorker()
        do {
            let response = try mockUsageResponse()
            let records = try mappingWorker.records(from: response.result)
            XCTAssert(records.count == 5, "Only \(records.count) parsed")
        } catch {
            XCTFail(error.localizedDescription)
        }

    }

    

}
