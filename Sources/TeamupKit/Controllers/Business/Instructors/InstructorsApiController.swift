//
//  InstructorsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 21/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

class InstructorsApiController: AuthenticatedApiController, InstructorsController {
    
}

// MARK: - Methods
extension InstructorsApiController {
    
    func loadAll(success: ((ResultsPage<Instructor>) -> Void)?,
                 failure: Controller.MethodFailure?) {
        
        let parameters: Alamofire.Parameters = [
            "business" : config.business.businessId
        ]
        
        let request = requestBuilder.build(for: .instructors,
                                           method: .get,
                                           parameters: parameters,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(TeamupError.unknown, nil)
                    return
                }
                do {
                    let instructors = try self.decoder.decode(ResultsPage<Instructor>.self, from: data)
                    success?(instructors)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
    
    func load(withId id: Int,
              success: ((Instructor) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        let request = requestBuilder.build(for: .instructor(id: id),
                                           method: .get,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(TeamupError.unknown, nil)
                    return
                }
                do {
                    let instructor = try self.decoder.decode(Instructor.self, from: data)
                    success?(instructor)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
}
