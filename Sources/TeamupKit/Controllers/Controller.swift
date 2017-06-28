//
//  Controller.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 28/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol Controller {
    
    // MARK: Types
    
    typealias MethodFailure = (TURequestError) -> Void
}
