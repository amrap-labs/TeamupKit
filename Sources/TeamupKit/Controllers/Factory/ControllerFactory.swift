//
//  ControllerFactory.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal protocol ControllerFactory {
    
    /// The active authentication controller.
    var authenticationController: AuthenticationController! { get }
    /// The active sessions controller.
    var sessionsController: SessionsController! { get }
    /// The active account controller.
    var accountController: AccountController! { get }
    /// The active business controller.
    var businessController: BusinessController! { get }
    
    /// Initialize all controllers.
    ///
    /// - Parameters:
    ///   - config: The configuration to use.
    ///   - requestBuilder: The request builder to use.
    ///   - requestExecutor: The request executor to use.
    ///   - apiToken: The active API token.
    func initialize(with config: Config,
                    requestBuilder: RequestBuilder,
                    requestExecutor: RequestExecutor,
                    apiToken: String)
}
