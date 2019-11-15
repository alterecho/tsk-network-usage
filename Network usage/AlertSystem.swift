//
//  AlertSystem.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 15/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

/// To show common alerts
class AlertSystem: UIViewController {
    static private var window: UIWindow?
    static private var alertVC: UIAlertController?

    static func alert(title: String?, message: String?) {
        alertVC?.dismiss(animated: false, completion: nil)

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()

        alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        guard let alertViewController = alertVC else {
            return
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            window = nil
            AlertSystem.alert(title: title, message: message)
        }
        alertViewController.addAction(okAction)
        window?.rootViewController = viewController
        window?.windowLevel = .alert + 1
        AlertSystem.window = window
        window?.makeKeyAndVisible()

        viewController.present(alertViewController, animated: true)
    }
}
