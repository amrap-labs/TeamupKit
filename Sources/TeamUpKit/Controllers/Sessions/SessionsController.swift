//
//  SessionsController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 19/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class SessionsController: AuthenticatedController, Sessions {
    
    // MARK: Sessions
    
    func load(between startDate: Date,
              and endDate: Date,
              includeRegistrationDetails: Bool = true,
              includeNonActive: Bool = false,
              success: (() -> Void)?,
              failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(config.business.businessId, for: "business")
        parameters.set(auth?.currentUser?.customer.id, for: "customer")
        parameters.set(includeRegistrationDetails, for: "include_registration_details")
        parameters.set(includeNonActive, for: "include_non_active")
        
        let request = requestBuilder.build(for: .sessions,
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
                let sessions = try self.decoder.decode(ResultsPage<Session>.self, from: data)
                dump(sessions)
            } catch {
                print(error)
                failure?(error)
            }
        })
        { (request, response, error) in
            
        }
    }
}
