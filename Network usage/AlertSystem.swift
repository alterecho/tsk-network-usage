//
//  AlertSystem.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 15/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

/// To show common alerts
public class AlertSystem: UIViewController {
    static private var window: UIWindow?
    static private var alertVC: UIAlertController?

    public static func alert(title: String?, message: String?) {
        alertVC?.dismiss(animated: false, completion: nil)

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC = alertViewController
        alertVC?.view.accessibilityIdentifier = AccessibilityIdentifiers.alertSystem

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            window = nil
        }
        alertViewController.addAction(okAction)
        window?.rootViewController = viewController
        window?.windowLevel = .alert + 1
        AlertSystem.window = window
        window?.makeKeyAndVisible()

        viewController.present(alertViewController, animated: true)
    }
}
