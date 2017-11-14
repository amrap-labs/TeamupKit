//
//  AccountApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class AccountApiController: AuthenticatedApiController, AccountController {
    
    // MARK: Properties
    
    var membershipsController: MembershipsApiController
    var memberships: MembershipsController {
        return membershipsController
    }
    
    // MARK: Init
    
    override init(with config: Config,
                  requestBuilder: RequestBuilder,
                  executor: RequestExecutor,
                  auth: TUAuthenticationController) {
        membershipsController = MembershipsApiController(with: config,
                                                         requestBuilder: requestBuilder,
                                                         executor: executor,
                                                         auth: auth)
        
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   executor: executor,
                   auth: auth)
    }
}
