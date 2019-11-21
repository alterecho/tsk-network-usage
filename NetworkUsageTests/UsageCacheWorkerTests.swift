//
//  UsageCacheWorkerTests.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 21/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class UsageCacheWorkerTests: XCTestCase {

    var cacheWorker: UsageCacheWorker?
    var records: [Models.UsageRecord] = []

    override func setUp() {
        cacheWorker = UsageCacheWorker()
        records.removeAll()
        let recordsCount = 9
        for i in 0..<recordsCount {
            let record = Models.UsageRecord(volumeOfData: Double(i),
                                   date: try? Models.Date(string: "2000-Q2"),
            id: "id\(i)")
            records.append(record)
        }
    }

    override func tearDown() {
        do {
            try cacheWorker?.clearCache()
        } catch {
            XCTFail(error.localizedDescription)
        }


    }

    func testRecordsCaching() {
        do {
            try cacheWorker?.cache(records: records)
            let cachedRecords = cacheWorker?.loadCachedRecords()
            XCTAssert(cachedRecords?.count == records.count, "only \(String(describing: cachedRecords?.count)) cached")
        } catch {
            XCTFail(error.localizedDescription)
        }

    }

    func testCacheClearing() {
        do {
            try cacheWorker?.cache(records: records)
            try cacheWorker?.clearCache()
            let records = cacheWorker?.loadCachedRecords()
            XCTAssert(records?.count == 0, "cache not cleared")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
