//
//  ApiRequestExecutor.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

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
        
        guard let executableRequest = request as? ExecutableRequest else {
            let error = RequestExecutorError.unknown
            failure(request, nil, error)
            return
        }
        let request = executableRequest
        
        request.inProgress = true
        print("requestBegin (\(request.url.absoluteString)")
        
        let dataRequest = Alamofire.request(request.url,
                                            method: request.method,
                                            parameters: request.parameters,
                                            encoding: request.encoding ?? URLEncoding.default,
                                            headers: request.headers)
        request.dataRequest = dataRequest
        
        // handle response
        dataRequest.response { (response) in
            
            // handle cancellation
            guard self.wasCancelled(error: response.error) == false else {
                failure(request, nil, RequestExecutorError.cancelled)
                return
            }
            
            guard let urlResponse = response.response else {
                failure(request, nil, RequestExecutorError.unknown)
                return
            }
            
            let response = Response(rawResponse: urlResponse,
                                    statusCode: urlResponse.statusCode,
                                    data: response.data,
                                    error: response.error)
            request.response = response
            request.inProgress = false
            
            // Handle failed request
            guard response.isSuccessful else {
                let error = response.error ?? RequestExecutorError.unknown
                print("requestFailed (\(request.url.absoluteString)) - status: \(response.statusCode), error: \(error)")
                failure(request, response, error)
                return
            }
            
            print("requestComplete (\(request.url.absoluteString)")
            success(request, response, response.data)
        }
    }
    
    // MARK: Utility
    
    func wasCancelled(error: Error?) -> Bool {
        guard let error = error else {
            return false
        }
        let nsError = error as NSError
        return nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorCancelled
    }
}
