//
//  AppSettingsStore.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 21/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class AppSettingsStore {
    enum keys: String {
        case startURL
    }

    static let shared = AppSettingsStore()

    init() {
        
    }

    func save(url: URL, key: String) {

    }

    func url(for key: String) -> URL? {
        return nil
    }
}
