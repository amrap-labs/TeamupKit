//
//  AuthenticatedApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 19/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// A controller that has access to the authentication controller.
class AuthenticatedApiController: ApiController {
    
    /// The active authentication service.
    weak private(set) var auth: AuthenticationController?
    
    // MARK: Init
    
    /// Create an authenticated controller.
    ///
    /// - Parameters:
    ///   - config: The configuration to use.
    ///   - requestBuilder: The request builder to use.
    ///   - executor: The request executor to use.
    ///   - auth: The authentication controller to provide.
    init(with config: Config,
         requestBuilder: RequestBuilder,
         executor: RequestExecutor,
         auth: AuthenticationController) {
        self.auth = auth
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   executor: executor)
    }
}
