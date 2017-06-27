//
//  ApiEnvironment.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// Environment configuration for live API.
internal class ApiEnvironment: Environment {
    
    var requestExecutorType: RequestExecutor.Type {
        return ApiRequestExecutor.self
    }
    
    var controllerFactoryType: ControllerFactory.Type {
        return ApiControllerFactory.self
    }
}
