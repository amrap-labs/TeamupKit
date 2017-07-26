//
//  MembershipsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

class MembershipsApiController: AuthenticatedApiController, MembershipsController {
    
    // MARK: Methods
    
    func loadAll(success: ((ResultsPage<Membership>) -> Void)?,
                 failure: Controller.MethodFailure?) {
        
        var parameters: Alamofire.Parameters = [
            "business" : config.business.businessId,
        ]
        if let customerId = auth?.currentUser?.customer.id {
            parameters["customer"] = customerId
        }
        
        let request = requestBuilder.build(for: .memberships,
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
                    let memberships = try self.decoder.decode(ResultsPage<Membership>.self, from: data)
                    success?(memberships)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
    
    func load(withId id: Int,
              success: ((Membership) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        let request = requestBuilder.build(for: .membership(id: id),
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
                    let membership = try self.decoder.decode(Membership.self, from: data)
                    success?(membership)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
}
