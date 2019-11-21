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

    var callExpectation: XCTestExpectation?

    override func setUp() {
        presenter = UsagePresenter()
        presenter?.output = self
    }

    func testDelegateCalls() {
        callExpectation = expectation(description: "update call expectation")
        presenter?.present(records: [])
        waitForExpectations(timeout: 1.0)
        callExpectation = expectation(description: "show alert expectation")
        presenter?.showAlert(title: "title", message: "message")
        waitForExpectations(timeout: 1.0)
        callExpectation = expectation(description: "show loading expectation")
        presenter?.showLoading()
        waitForExpectations(timeout: 1.0)
        callExpectation = expectation(description: "hide loading expectation")
        presenter?.hideLoading()
        waitForExpectations(timeout: 1.0)
    }
}


extension UsagePresenterTests: UsagePresenterOutputProtocol {
    func showLoading() {
        callExpectation?.fulfill()
    }

    func hideLoading() {
        callExpectation?.fulfill()
    }

    func update(vm: UsageViewVM) {
        callExpectation?.fulfill()
    }

    func showAlert(title: String, message: String) {
        callExpectation?.fulfill()
    }
}
