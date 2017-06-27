//
//  ControllerFactory.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal protocol ControllerFactory {
    
    var authenticationController: AuthenticationController! { get }
    var sessionsController: SessionsController! { get }
    var accountController: AccountController! { get }
    var businessController: BusinessController! { get }
    
    func initialize(with config: Config,
                    requestBuilder: RequestBuilder,
                    requestExecutor: RequestExecutor,
                    apiToken: String)
}
