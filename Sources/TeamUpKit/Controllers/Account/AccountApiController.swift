//
//  AccountApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class AccountApiController: AuthenticatedController, AccountController {
    
    // MARK: Properties
    
    var membershipsController: MembershipsController
    var memberships: Memberships {
        return membershipsController
    }
    
    // MARK: Init
    
    override init(with config: Config,
                  requestBuilder: RequestBuilder,
                  executor: RequestExecutor,
                  auth: AuthenticationController) {
        membershipsController = MembershipsController(with: config,
                                                      requestBuilder: requestBuilder,
                                                      executor: executor,
                                                      auth: auth)
        
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   executor: executor,
                   auth: auth)
    }
}
