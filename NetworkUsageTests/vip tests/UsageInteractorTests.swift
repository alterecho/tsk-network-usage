//
//  UsageInteractorTests.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 22/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
@testable import NetworkUsage

class UsageInteractorTests: XCTestCase {

    var expectation: XCTestExpectation?

    var interactor: UsageInteractor?

    // protocol conformation
    var output: UsagePresenterOutputProtocol?

    var presentRecordsExpectation: XCTestExpectation?
    var showAlertExpectation: XCTestExpectation?
    var showLoadingExpectation: XCTestExpectation?
    var hideLoadingExpectation: XCTestExpectation?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = UsageInteractor()
        interactor?.output = self
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoad() {

        presentRecordsExpectation = expectation(description: "present records")
        showLoadingExpectation = expectation(description: "show loading records")
        hideLoadingExpectation = expectation(description: "hide loading records")


        interactor?.load()
        waitForExpectations(timeout: 2.0)

    }

    func testReachedEndOfPage() {
        presentRecordsExpectation = expectation(description: "present records")
        showLoadingExpectation = expectation(description: "show loading records")
        hideLoadingExpectation = expectation(description: "hide loading records")

        interactor?.reachedEndOfPage()
        waitForExpectations(timeout: 2.0)
    }

}

extension UsageInteractorTests: UsagePresenterInputProtocol {


    func present(records: [[Models.UsageRecord]]) {
        presentRecordsExpectation?.fulfill()
    }

    func showAlert(title: String, message: String) {
        showAlertExpectation?.fulfill()
    }

    func showLoading() {
        showLoadingExpectation?.fulfill()
    }

    func hideLoading() {
        hideLoadingExpectation?.fulfill()
    }

    
}
