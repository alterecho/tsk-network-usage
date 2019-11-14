//
//  UsageViewController.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

class UsageViewController: UIViewController {
    var output: UsageInteractorInputProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        if output == nil {
            UsageConfigurator().configure(viewController: self)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.green
        output?.load()
    }

}

extension UsageViewController: UsagePresenterOutputProtocol {
    func update(vm: UsageViewVM) {

    }
}
