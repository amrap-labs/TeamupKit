//
//  ApiRequestExecutor.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// Live API Request executor.
internal class ApiRequestExecutor: RequestExecutor {
    
    // MARK: Properties
    
    /// The URL session the executor is using.
    private var urlSession: URLSession! = URLSession.shared
    /// The data tasks that are currently in progress.
    private var dataTasks = [URL : URLSessionDataTask]()
    
    /// The object that is acting as a responder for auth execution.
    weak var authResponder: RequestExecutorAuthResponder?
    
    // MARK: Init
    
    required init() {
        
    }
    
    deinit {
        self.urlSession = nil
        self.dataTasks.removeAll()
    }
    
    // MARK: Execution
    
    func execute(request: Request,
                 success: @escaping RequestExecutor.ExecutionSuccess,
                 failure: @escaping RequestExecutor.ExecutionFailure) {
        
        // add parameters to url if required
        var url = request.url
        if request.parameters?.count ?? 0 > 0 {
            let urlString = request.url.absoluteString
            url = URL(string: "\(urlString)?\(request.parameters!.data.stringFromHttpParameters())")!
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
        request.headers?.data.forEach({ (header) in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        })
        urlRequest.addValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        // perform task
        let authResponder = self.authResponder
        let task = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let welf = self else { return }
            welf.dataTasks.removeValue(forKey: url)
            
            // attempt to read response
            guard let response = Response(with: response,
                                            and: data,
                                            for: request,
                                            error: error) else
            {
                failure(request, nil, RequestError.unknown)
                return
            }
            
            guard response.isSuccessful == true else { // handle error
                
                // Attempt reauth if 401
                if response.statusCode == .unauthorized {
                    authResponder?.requestExecutor(welf,
                                                   encounteredUnauthorizedErrorWhenExecuting: request,
                                                   response: response,
                                                   success: success,
                                                   failure: failure)
                    return
                }
                
                let error = response.error!
                print("requestFailed (\(url.absoluteString)) - error: \(error)")
                failure(request, response, error)
                return
            }
            
            print("requestComplete (\(url.absoluteString)")
            success(request, response, data)
        }
        dataTasks[url] = task
        
        print("requestBegin (\(url.absoluteString)")
        task.resume()
    }
}
