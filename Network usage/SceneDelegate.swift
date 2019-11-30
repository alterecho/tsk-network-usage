//
//  SceneDelegate.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 30/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    }
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        TestArgsHandler.handleTestArgs()
    }
}
