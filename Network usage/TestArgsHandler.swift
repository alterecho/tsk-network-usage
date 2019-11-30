//
//  TestArgsHandler.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 30/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class TestArgsHandler {
    static func handleTestArgs() {
        if ProcessInfo.processInfo.arguments.contains(LaunchArgs.testAlert) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                AlertSystem.alert(title: "tst", message: "alert")
            }
        }
    }
}
