//
//  MembershipsController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class MembershipsController: AuthenticatedController, Memberships {
    
    // MARK: Methods
    
    func loadAll(success: ((ResultsPage<Membership>) -> Void)?,
                 failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(auth?.currentUser?.customer.id, for: "customer")
        parameters.set(config.business.businessId, for: "business")
        
        let request = requestBuilder.build(for: .memberships,
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
                    let memberships = try self.decoder.decode(ResultsPage<Membership>.self, from: data)
                    success?(memberships)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
    
    func loadMembership(withId id: Int,
                        success: ((Membership) -> Void)?,
                        failure: Controller.MethodFailure?) {
        
        let request = requestBuilder.build(for: .membership(id: id),
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
                    let membership = try self.decoder.decode(Membership.self, from: data)
                    success?(membership)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}
