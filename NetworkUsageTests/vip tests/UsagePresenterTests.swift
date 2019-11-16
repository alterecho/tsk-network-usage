//
//  UsagePresenterTests.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 16/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class UsagePresenterTests: XCTestCase {
    var presenter: UsagePresenterInputProtocol?

    var updateCallExpectation: XCTestExpectation?
    var showAlertExpectation: XCTestExpectation?

    override func setUp() {
        presenter = UsagePresenter()
        presenter?.output = self
    }

    func testUpdateCall() {
        updateCallExpectation = expectation(description: "expect update called")
        presenter?.present(records: [])
        waitForExpectations(timeout: 1.0)
        
    }

    func testShowAlertCall() {
        showAlertExpectation = expectation(description: "expect show alert called")
        presenter?.showAlert(title: "title", message: "message")
        waitForExpectations(timeout: 1.0)
    }
    
}


extension UsagePresenterTests: UsagePresenterOutputProtocol {
    func update(vm: UsageViewVM) {
        updateCallExpectation?.fulfill()
    }

    func showAlert(title: String, message: String) {
        showAlertExpectation?.fulfill()
    }
}
