//
//  ApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// A controller that is used to interact with an element of the service.
public class ApiController: PageableController {
    
    // MARK: Properties
    
    /// The configuration for the controller.
    internal let config: Config
    /// The request builder.
    internal let requestBuilder: RequestBuilder
    /// The request executor.
    internal let requestExecutor: RequestExecutor
    
    /// The JSON Decoder.
    internal let decoder = JSONDecoder()
    
    // MARK: Init
    
    /// Create a controller.
    ///
    /// - Parameters:
    ///   - config: The configuration to use.
    ///   - requestBuilder: The request builder to use.
    ///   - executor: The request executor to use.
    internal init(with config: Config,
         requestBuilder: RequestBuilder,
         executor: RequestExecutor) {
        self.config = config
        self.requestBuilder = requestBuilder
        self.requestExecutor = executor
    }
    
    // MARK: Methods
    
    public func loadPage<DataType>(at index: ResultsPage<DataType>.Index,
                                   for results: ResultsPage<DataType>,
                                   success: ((ResultsPage<DataType>) -> Void)?,
                                   failure: Controller.MethodFailure?) {
        guard let url = results.pageUrl(for: index) else {
            failure?(RequestError(with: TeamupError.Paging.pageNotFound))
            return
        }
        
        let request = requestBuilder.build(for: url,
                                           method: .get,
                                           contentType: .json,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(RequestError.unknown)
                    return
                }
                do {
                    let results = try self.decoder.decode(ResultsPage<DataType>.self, from: data)
                    success?(results)
                } catch {
                    failure?(RequestError(with: error))
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}
