//
//  AuthenticatedController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 19/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class AuthenticatedController: Controller {
    
    /// The active authentication service.
    weak private(set) var auth: AuthenticationController?
    
    // MARK: Init
    
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
