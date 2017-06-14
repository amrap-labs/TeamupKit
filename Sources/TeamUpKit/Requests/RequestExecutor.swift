//
//  RequestExecutor.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class RequestExecutor {
    
    // MARK: Properties
    
    private var urlSession = URLSession.shared
    
    private var dataTasks = [URL : URLSessionDataTask]()
    
    // MARK: Execution
    
    func execute(request: Request) {
        
        // add parameters to url if required
        var url = request.url
        if request.parameters.count > 0 {
            let urlString = request.url.absoluteString
            url = URL(string: "\(urlString)?\(request.parameters.stringFromHttpParameters())")!
        }
        
        // avoid duplicate requests
        guard dataTasks[url] == nil else {
            // TODO - Handle pending completions
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        // add headers
        for header in request.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        urlRequest.addValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        // perform task
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            self.dataTasks.removeValue(forKey: url)
            
            guard error == nil && data == nil else { // handle error
                print("error: \(error)")
                return
            }
            
            let dataString =  String(data: data!, encoding: String.Encoding.utf8)
            print("data: \(dataString)")
        }
        dataTasks[url] = task
        task.resume()
    }
}
