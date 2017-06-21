//
//  InstructorsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 21/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class InstructorsApiController: AuthenticatedController, InstructorsController {
    
}

// MARK: - Methods
extension InstructorsApiController {
    
    func loadAll(success: ((ResultsPage<Instructor>) -> Void)?,
                 failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(config.business.businessId, for: "business")
        
        let request = requestBuilder.build(for: .instructors,
                                           method: .get,
                                           contentType: .json,
                                           parameters: parameters,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(RequestError.unknown)
                    return
                }
                do {
                    let instructors = try self.decoder.decode(ResultsPage<Instructor>.self, from: data)
                    success?(instructors)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}
