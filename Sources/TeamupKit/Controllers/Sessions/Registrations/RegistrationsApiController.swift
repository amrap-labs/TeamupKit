//
//  RegistrationsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class RegistrationsApiController: AuthenticatedController, RegistrationsController {
    
}

// MARK: - Registration Details
extension RegistrationsApiController {
    
    func loadDetails(forSession session: Session,
                     success: ((Session.RegistrationDetails) -> Void)?,
                     failure: Controller.MethodFailure?) {
        
//        var parameters = Request.Parameters()
//        parameters.set(auth?.currentUser?.customer.id, for: "customer")
//
//        let request = requestBuilder.build(for: .sessionRegistration(sessionId: session.id),
//                                           method: .get,
//                                           contentType: .json,
//                                           parameters: parameters,
//                                           authentication: .userToken)
//        requestExecutor.execute(request: request,
//                                success:
//            { (request, response, data) in
//                guard let data = data else {
//                    failure?(RequestError.unknown)
//                    return
//                }
//                do {
//                    let registrationDetails = try self.decoder.decode(Session.RegistrationDetails.self, from: data)
//                    success?(registrationDetails)
//                } catch {
//                    failure?(RequestError(with: error))
//                }
//        }) { (request, response, error) in
//            failure?(error)
//        }
    }
}

// MARK: - Registration Updating
extension RegistrationsApiController {
    
    func updateState(forSession session: Session,
                     to newState: Session.RegistrationState,
                     membership: Membership?,
                     success: ((Session.RegistrationState) -> Void)?,
                     failure: Controller.MethodFailure?) {
        
//        var body = Request.Body()
//        body.add(auth?.currentUser?.customer.id, for: "customer")
//        body.add(newState.rawValue, for: "action")
//        body.add(membership?.id, for: "consumermembership")
//        
//        let request = requestBuilder.build(for: .sessionRegistration(sessionId: session.id),
//                                           method: .post,
//                                           contentType: .formUrlEncoded,
//                                           body: body,
//                                           authentication: .userToken)
//        requestExecutor.execute(request: request,
//                                success:
//            { (request, response, data) in
//                success?(newState)
//        }) { (request, response, error) in
//            failure?(error)
//        }
    }
}
