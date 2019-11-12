//
//  UsageView.swift
//  Network Usage
//
//  Created by v.a.jayachandran on 12/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

protocol UsageViewInteractor {
    func load()
    func reachedEndOfPage()
}

protocol UsageViewPresenter {
    func display()
}


