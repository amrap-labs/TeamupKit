//
//  MockRequestExecutor.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
@testable import TeamupKit

class MockRequestExecutor: RequestExecutor {
    
    // MARK: Properties
    
    var authResponder: RequestExecutorAuthResponder?
    
    // MARK: Init
    
    required init() {
        
    }
    
    // MARK: Execution
    
    func execute(request: TURequest,
                 success: @escaping RequestExecutor.ExecutionSuccess,
                 failure: @escaping RequestExecutor.ExecutionFailure) {
        
    }
}
