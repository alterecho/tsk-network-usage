//
//  UsageCacheWorker.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 20/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsageCacheWorker: UsageCacheWorkerProtocol {
    let coreData: CoreDataStore

    init() {
        coreData = CoreDataStore.shared
    }

    func cache(links: Models.UsageResponse.Result.PageLinks) {
        
    }

    func cache(records: [Models.UsageRecord]) throws {
        try coreData.save(records: records)
    }

    func loadCachedRecords() -> [Models.UsageRecord]? {
        do {
            return try coreData.retrieveAllRecords()
        } catch {
            print(error)
            return nil
        }
    }

    func clearCache() throws {
        try coreData.deleteAllRecords()
    }

}
