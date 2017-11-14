//
//  ApiControllerFactory.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal class ApiControllerFactory: ControllerFactory {
    
    // MARK: Properties
    
    private(set) var authenticationController: TUAuthenticationController!
    private(set) var sessionsController: SessionsController!
    private(set) var accountController: AccountController!
    private(set) var businessController: BusinessController!
    
    // MARK: Init
    
    required init() {
        
    }
    
    // MARK: Controller Initialization
    
    func initialize(with config: Config,
                    requestBuilder: RequestBuilder,
                    requestExecutor: RequestExecutor,
                    apiToken: String) {
        self.authenticationController = AuthenticationApiController(with: config,
                                                                    requestBuilder: requestBuilder,
                                                                    executor: requestExecutor,
                                                                    apiToken: apiToken)
        
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
