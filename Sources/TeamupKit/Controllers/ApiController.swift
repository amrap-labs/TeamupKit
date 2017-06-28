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
    
    public func loadPage<DataType>(at index: ResultsPage<DataType>.Index,
                                   for results: ResultsPage<DataType>,
                                   success: ((ResultsPage<DataType>) -> Void)?,
                                   failure: Controller.MethodFailure?) {
        // TODO - Perform request
    }
}
