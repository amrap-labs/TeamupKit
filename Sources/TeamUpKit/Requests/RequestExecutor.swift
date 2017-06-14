//
//  RequestExecutor.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class RequestExecutor {
    
    private var urlSession = URLSession.shared
    
    // MARK: Execution
    
    func execute(request: Request) {
        
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        for header in request.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                let dataString =  String(data: data, encoding: String.Encoding.utf8)
                print("data: \(dataString)")
            }
            print("response: \(response)")
            print("error: \(error)")
        }
        task.resume()
    }
}
