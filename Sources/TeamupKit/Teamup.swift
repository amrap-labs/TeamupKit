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
    
    /// The active configuration.
    internal let config: Config
    /// The active request builder.
    internal var requestBuilder: RequestBuilder!
    /// The active request executor.
    internal var requestExecutor: RequestExecutor!
    
    /// The active factory for building controllers.
    private let controllerFactory: ControllerFactory
    
    /// The active authentication controller.
    public var auth: TUAuthenticationController {
        return controllerFactory.authenticationController
    }
    /// The active sessions controller.
    public var sessions: TUSessionsController {
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
    
    public convenience init(apiToken: String,
                businessId: Int,
                apiVersion: ApiConfig.Version = .current) {
        self.init(apiToken: apiToken,
                  businessId: businessId,
                  apiVersion: apiVersion,
                  environment: nil)
    }
    
    internal init(apiToken: String,
                  businessId: Int,
                  apiVersion: ApiConfig.Version,
                  environment: Environment?) {
        self.config = Config(businessId: businessId,
                             apiVersion: apiVersion)
        var environment: Environment! = environment
        if environment == nil {
            environment = ApiEnvironment()
        }
        
        self.requestBuilder = RequestBuilder(with: config,
                                             urlBuilder: UrlBuilder(with: config))
        self.requestExecutor = environment.requestExecutorType.init()
        
        self.controllerFactory = environment.controllerFactoryType.init()
        controllerFactory.initialize(with: self.config,
                                     requestBuilder: self.requestBuilder,
                                     requestExecutor: self.requestExecutor,
                                     apiToken: apiToken)
    }
}
