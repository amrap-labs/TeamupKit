//
//  MockEnvironment.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
@testable import TeamupKit

class MockEnvironment: Environment {
    
    var requestExecutorType: RequestExecutor.Type {
        return MockRequestExecutor.self
    }
    
    var controllerFactoryType: ControllerFactory.Type {
        return MockControllerFactory.self
    }
}
