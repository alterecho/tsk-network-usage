//
//  AlertSystemTests.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 22/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import XCTest
//@testable import NetworkUsage

class AlertSystemTests: XCTestCase {

    var app: XCUIApplication?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlertShows() {
        app = XCUIApplication()
        app?.launch()
        AlertSystem.alert(title: "title", message: "message")
        print(app?.alerts)
        let query = app?.otherElements["alertsystem"]
        XCTAssert(query?.waitForExistence(timeout: 5.0) ?? false)
    }
}
