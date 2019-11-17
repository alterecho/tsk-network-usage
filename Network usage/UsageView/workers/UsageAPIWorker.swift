//
//  UsageAPIWorker.swift
//  NetworkUsage
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

class UsageAPIWorker: UsageAPIWorkerProtocol {
    func fetchUsageData(resourceID: String, limit: Int, completionHandler: @escaping (Models.UsageResponse?, Error?) -> ()) throws {
        
//        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
//            return
        //        }
        let urlString = URLStrings.base.appending("\(URLStrings.dataPath)?resource_id=\(resourceID)&limit=\(limit)")
        guard let url = URL(string: urlString) else {
            throw Errors.invalidURL("invalid URL \(urlString)")
        }

        let request = URLRequest(url: url)
        print(url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let usageResponse = try JSONDecoder().decode(Models.UsageResponse.self, from: data)
                    DispatchQueue.main.async {
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
