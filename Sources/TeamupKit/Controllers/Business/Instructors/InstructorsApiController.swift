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
        
        var parameters = TURequest.Parameters()
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
    
    func load(withId id: Int,
              success: ((Instructor) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        let request = requestBuilder.build(for: .instructor(id: id),
                                           method: .get,
                                           contentType: .json,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(RequestError.unknown)
                    return
                }
                do {
                    let instructor = try self.decoder.decode(Instructor.self, from: data)
                    success?(instructor)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}
