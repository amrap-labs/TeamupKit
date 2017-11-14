//
//  ControllerFactory.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal protocol ControllerFactory: class {
    
    // MARK: Properties
    
    /// The active authentication controller.
    var authenticationController: TUAuthenticationController! { get }
    /// The active sessions controller.
    var sessionsController: TUSessionsController! { get }
    /// The active account controller.
    var accountController: AccountController! { get }
    /// The active business controller.
    var businessController: BusinessController! { get }
    
    // MARK: Init
    
    init()
    
    // MARK: Controller Initialization
    
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
