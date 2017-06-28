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
    
    typealias MethodFailure = (TURequestError) -> Void
}

/// A Controller that provides pageable content.
public protocol PageableController: Controller {
    
    // MARK: Methods
    
    func loadNextPage<DataType>(of results: ResultsPage<DataType>,
                                success: ((ResultsPage<DataType>) -> Void)?,
                                failure: Controller.MethodFailure?)
}
