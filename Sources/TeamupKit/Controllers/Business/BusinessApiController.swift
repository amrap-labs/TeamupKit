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

// MARK: - BusinessController Methods
extension BusinessApiController {
    
    func load(success: ((Business) -> Void)?,
              failure: Controller.MethodFailure?) {
        load(withId: config.business.businessId,
             success: success,
             failure: failure)
    }
    
    func load(withId id: Int,
              success: ((Business) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        let request = requestBuilder.build(for: .business(id: id),
                                           method: .get,
                                           contentType: .json,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(TURequestError.unknown.raw)
                    return
                }
                do {
                    let business = try self.decoder.decode(Business.self, from: data)
                    success?(business)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error.raw)
        }
    }
}
