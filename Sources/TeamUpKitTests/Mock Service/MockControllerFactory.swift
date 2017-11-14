//
//  MockControllerFactory.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 26/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
@testable import TeamupKit

class MockControllerFactory: ControllerFactory {
    
    var authenticationController: TUAuthenticationController!
    var sessionsController: SessionsController!
    var accountController: AccountController!
    var businessController: BusinessController!
    
    required init() {
        
    }
    
    func initialize(with config: Config,
                    requestBuilder: RequestBuilder,
                    requestExecutor: RequestExecutor,
                    apiToken: String) {
        self.authenticationController = AuthenticationMockController(with: config,
                                                                     requestBuilder: requestBuilder,
                                                                     executor: requestExecutor)
        
        self.sessionsController = SessionsApiController(with: config,
                                                        requestBuilder: requestBuilder,
                                                        executor: requestExecutor,
                                                        auth: authenticationController)
        self.accountController = AccountApiController(with: config,
                                                      requestBuilder: requestBuilder,
                                                      executor: requestExecutor,
                                                      auth: authenticationController)
        self.businessController = BusinessApiController(with: config,
                                                        requestBuilder: requestBuilder,
                                                        executor: requestExecutor,
                                                        auth: authenticationController)
    }
    
    
}
