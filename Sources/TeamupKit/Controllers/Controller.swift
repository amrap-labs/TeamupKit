//
//  Controller.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 28/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// A Controller that interacts with a component of the API.
public protocol Controller {
    
    // MARK: Types
    
    typealias MethodFailure = (Error) -> Void
}

/// A Controller that provides pageable content.
public protocol PageableController: Controller {
    
    // MARK: Methods
    
    /// Load another page of results.
    ///
    /// - Parameters:
    ///   - index: The index of results to load.
    ///   - results: The original page of results.
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func loadPage<DataType>(at index: ResultsPage<DataType>.Index,
                            for results: ResultsPage<DataType>,
                            success: ((ResultsPage<DataType>) -> Void)?,
                            failure: Controller.MethodFailure?)
}
