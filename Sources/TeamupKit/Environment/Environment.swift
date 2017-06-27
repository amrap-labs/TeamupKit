//
//  Environment.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// Environment configuration
internal protocol Environment {
    
    /// The type of request executor to use in the current environment.
    var requestExecutorType: RequestExecutor.Type { get }
    
    /// The controller factory to use in the current environment.
    var controllerFactoryType: ControllerFactory.Type { get }
}
