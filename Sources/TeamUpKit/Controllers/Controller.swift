//
//  Controller.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class Controller {
    
    // MARK: Types
    
    public typealias MethodFailure = (TURequestError) -> Void
    
    // MARK: Properties
    
    let config: Config
    let requestBuilder: RequestBuilder
    let requestExecutor: RequestExecutor
    
    let decoder = JSONDecoder()
    
    // MARK: Init
    
    init(with config: Config,
         requestBuilder: RequestBuilder,
         executor: RequestExecutor) {
        self.config = config
        self.requestBuilder = requestBuilder
        self.requestExecutor = executor
    }
}
