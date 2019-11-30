//
//  SceneDelegate.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 30/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        TestArgsHandler.handleTestArgs()
    }
}
