//
//  RegistrationsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

class RegistrationsApiController: AuthenticatedController, RegistrationsController {
    
}

// MARK: - Registration Details
extension RegistrationsApiController {
    
    func loadDetails(forSession session: Session,
                     success: ((Session.RegistrationDetails) -> Void)?,
                     failure: Controller.MethodFailure?) {
        
        var parameters: Alamofire.Parameters = [:]
        if let customerId = auth?.currentUser?.customer.id {
            parameters["customer"] = customerId
        }
        
        let request = requestBuilder.build(for: .sessionRegistration(sessionId: session.id),
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
                    let registrationDetails = try self.decoder.decode(Session.RegistrationDetails.self, from: data)
                    success?(registrationDetails)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
}

// MARK: - Registration Updating
extension RegistrationsApiController {
    
    func updateState(forSession session: Session,
                     to newState: Session.RegistrationState,
                     membership: Membership?,
                     success: ((Session.RegistrationState) -> Void)?,
                     failure: Controller.MethodFailure?) {
        
        var parameters: Alamofire.Parameters = [
            "action" : newState.rawValue
        ]
        if let membershipId = membership?.id {
            parameters["consumermembership"] = membershipId
        }
        
        let request = requestBuilder.build(for: .sessionRegistration(sessionId: session.id),
                                           method: .post,
                                           parameters: parameters,
                                           encoding: URLEncoding.httpBody,
                                           authentication: .userToken)
        
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                success?(newState)
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
}
