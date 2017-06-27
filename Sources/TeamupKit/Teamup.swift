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
    
    private let controllerFactory: ControllerFactory
    
    /// The active authentication controller.
    public var auth: AuthenticationController {
        return controllerFactory.authenticationController
    }
    /// The active sessions controller.
    public var sessions: SessionsController {
        return controllerFactory.sessionsController
    }
    /// The active account controller.
    public var account: AccountController {
        return controllerFactory.accountController
    }
    /// The active business controller.
    public var business: BusinessController {
        return controllerFactory.businessController
    }
    
    // MARK: Init
    
    public init(apiToken: String,
                businessId: Int,
                apiVersion: ApiConfig.Version = .current) {
        self.config = Config(businessId: businessId,
                             apiVersion: apiVersion)
        self.controllerFactory = ApiControllerFactory()
        
        initComponents(with: config)
        controllerFactory.initialize(with: config,
                                     requestBuilder: requestBuilder,
                                     requestExecutor: requestExecutor,
                                     apiToken: apiToken)
    }
    
    private func initComponents(with config: Config) {
        
        self.requestBuilder = RequestBuilder(with: config,
                                             urlBuilder: UrlBuilder(with: config))
        self.requestExecutor = RequestExecutor()
    }
}
