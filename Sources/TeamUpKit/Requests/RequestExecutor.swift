//
//  RequestExecutor.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol RequestExecutorAuthResponder: class {
    
    func requestExecutor(_ executor: RequestExecutor,
                         encounteredUnauthorizedErrorWhenExecuting request: Request,
                         response: Response,
                         success: @escaping RequestExecutor.ExecutionSuccess,
                         failure: @escaping RequestExecutor.ExecutionFailure)
}

class RequestExecutor {
    
    // MARK: Types
    
    typealias ExecutionSuccess = (_ request: Request, _ response: Response, _ data: Data?) -> Void
    typealias ExecutionFailure = (_ request: Request, _ response: Response?, _ error: Error) -> Void
    
    // MARK: Properties
    
    private var urlSession = URLSession.shared
    private var dataTasks = [URL : URLSessionDataTask]()
    
    weak var authResponder: RequestExecutorAuthResponder?
    
    // MARK: Execution
    
    func execute(request: Request,
                 success: @escaping ExecutionSuccess,
                 failure: @escaping ExecutionFailure) {
        
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
        for header in request.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        urlRequest.addValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        // perform task
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            self.dataTasks.removeValue(forKey: url)
            
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
                    self.authResponder?.requestExecutor(self,
                                                        encounteredUnauthorizedErrorWhenExecuting: request,
                                                        response: response,
                                                        success: success,
                                                        failure: failure)
                    return
                }
                
                let error = response.error!
                print("requestFailed (\(url.absoluteString)) - error: \(error), statusCode: \(response.statusCode.rawValue)")
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
