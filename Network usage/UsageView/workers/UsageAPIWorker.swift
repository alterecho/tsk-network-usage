//
//  UsageAPIWorker.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsageAPIWorker: UsageAPIWorkerProtocol {
    var resourceID: String?
    var limit = 20
    var offset = 0
    
    private var currentFetchPath: String?
    private var nextFetchPath: String?

    var nextURL: URL? = nil

    init() {
        //start resourceID
        resourceID = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        constructNextURL()
    }

    private func constructNextURL() {
        if let nextFetchPath = nextFetchPath {
            nextURL = URL(string: URLStrings.base + nextFetchPath)
        } else if let resourceID = resourceID {
            // descending order search
            nextURL = URL(string: URLStrings.base.appending("\(URLStrings.dataPath)?resource_id=\(resourceID)&limit=\(limit)&sort=quarter%20desc"))
        } else {
            nextURL = nil
        }

    }

    func fetchUsageData(completionHandler: @escaping (Models.UsageResponse?, Error?) -> ()) throws {
//        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
//            return
        //        }
        guard let url = nextURL else {
            completionHandler(nil, nil)
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                do {
                    let usageResponse = try JSONDecoder().decode(Models.UsageResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.nextFetchPath = usageResponse.result.links.next.absoluteString
                        self?.constructNextURL()
                        completionHandler(usageResponse, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(nil, error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(nil, Errors.fileNotFound(error?.localizedDescription ?? "file not found"))
                }

            }
        }.resume()
    }

    
}
