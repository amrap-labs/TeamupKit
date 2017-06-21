//
//  Teamup.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class Teamup {
    
    // MARK: Properties
    
    private let config: Config
    private var requestBuilder: RequestBuilder!
    private var requestExecutor: RequestExecutor!
    
    public private(set) var auth: AuthenticationController!
    public private(set) var sessions: SessionsController!
    public private(set) var account: AccountController!
    public private(set) var business: BusinessController!
    
    // MARK: Init
    
    public init(apiToken: String,
                businessId: Int,
                apiVersion: ApiConfig.Version = .current) {
        self.config = Config(businessId: businessId,
                             apiVersion: apiVersion)
        initComponents(with: config)
        initAuthControllers(with: config,
                            requestBuilder: requestBuilder,
                            executor: requestExecutor,
                            apiToken: apiToken)
        initControllers(with: config,
                        requestBuilder: requestBuilder,
                        executor: requestExecutor,
                        auth: self.auth)
    }
    
    private func initComponents(with config: Config) {
        
        self.requestBuilder = RequestBuilder(with: config,
                                             urlBuilder: UrlBuilder(with: config))
        self.requestExecutor = RequestExecutor()
    }
    
    private func initAuthControllers(with config: Config,
                                     requestBuilder: RequestBuilder,
                                     executor: RequestExecutor,
                                     apiToken: String) {
        let authController = AuthenticationApiController(with: config,
                                                         requestBuilder: requestBuilder,
                                                         executor: requestExecutor,
                                                         apiToken: apiToken)
        requestBuilder.authProvider = authController
        executor.authResponder = authController
        self.auth = authController
    }
    
    private func initControllers(with config: Config,
                                 requestBuilder: RequestBuilder,
                                 executor: RequestExecutor,
                                 auth: AuthenticationController) {
        let sessionsController = SessionsApiController(with: config,
                                                       requestBuilder: requestBuilder,
                                                       executor: executor,
                                                       auth: auth)
        self.sessions = sessionsController
        
        let accountController = AccountApiController(with: config,
                                                     requestBuilder: requestBuilder,
                                                     executor: executor,
                                                     auth: auth)
        self.account = accountController
        
        let businessController = BusinessApiController(with: config,
                                                       requestBuilder: requestBuilder,
                                                       executor: executor,
                                                       auth: auth)
        self.business = businessController
    }
}
