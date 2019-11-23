//
//  AppDelegate.swift
//  Network Usage
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        handleTestArgs()
        return true
    }
}

extension AppDelegate {
    func handleTestArgs() {
        if ProcessInfo.processInfo.arguments.contains(LaunchArgs.testAlert) {
            AlertSystem.alert(title: "tst", message: "alert")
        }
    }
}

