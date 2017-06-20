//
//  RegistrationsController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class RegistrationsController: AuthenticatedController, Registrations {
    
}

// MARK: - Registration Details
extension RegistrationsController {
    
    func loadDetails(forSession session: Session,
                     success: ((Session.RegistrationDetails) -> Void)?,
                     failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(auth?.currentUser?.customer.id, for: "customer")
        
        let request = requestBuilder.build(for: .registration(sessionId: session.id),
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
                    let registrationDetails = try self.decoder.decode(Session.RegistrationDetails.self, from: data)
                    success?(registrationDetails)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}

// MARK: - Registration Updating
extension RegistrationsController {
    
    func updateState(forSession session: Session,
                     to: Session.RegistrationState,
                     success: ((Session.RegistrationState) -> Void)?,
                     failure: Controller.MethodFailure?) {
        
    }
}
