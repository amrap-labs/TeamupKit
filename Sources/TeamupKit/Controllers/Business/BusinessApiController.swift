//
//  BusinessApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class BusinessApiController: AuthenticatedController, BusinessController {
    
    // MARK: Properties
    
    private var instructorsController: InstructorsApiController
    var instructors: InstructorsController {
        return instructorsController
    }
    
    // MARK: Init
    
    override init(with config: Config,
                  requestBuilder: RequestBuilder,
                  executor: RequestExecutor,
                  auth: AuthenticationController) {
        instructorsController = InstructorsApiController(with: config,
                                                         requestBuilder: requestBuilder,
                                                         executor: executor,
                                                         auth: auth)
        
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   executor: executor,
                   auth: auth)
    }
}
