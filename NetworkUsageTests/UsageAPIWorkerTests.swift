//
//  UsageAPIWorker.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 22/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class MockDataTask: URLSessionDataTaskProtocol {
    private(set) var resumed = false

    func resume() {
        resumed = true
    }
    
}

class MockSession: URLSessionProtocol {
    private let dataTask: MockDataTask

    init(dataTask: MockDataTask) {
        self.dataTask = dataTask
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask
    }
}

class UsageAPIWorkerTests: XCTestCase {

    var apiWorker: UsageAPIWorker?
    let mockDataTask = MockDataTask()

    override func setUp() {
        apiWorker = UsageAPIWorker(session: MockSession(dataTask: mockDataTask))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataBeingFetched() {
        try? apiWorker?.fetchUsageData(completionHandler: { (response, error) in
            
        })

        XCTAssert(mockDataTask.resumed, "resume was not called")
    }

}
