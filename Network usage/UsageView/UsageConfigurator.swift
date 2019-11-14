//
//  UsageConfigurator.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsageConfigurator {
    func configure(
        viewController: UsageViewController, interactor: UsageInteractorInputProtocol = UsageInteractor(),
        presenter: UsagePresenterInputProtocol = UsagePresenter()) {

        interactor.output = presenter
        viewController.output = interactor
        
    }
}
