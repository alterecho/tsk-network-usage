//
//  URLSessionProtocol.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 22/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import Foundation

/// For dependency injection


protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {

}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
