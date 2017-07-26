//
//  WaitlistsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

class WaitlistsApiController: AuthenticatedController, WaitlistsController {
    
    func load(forSession session: Session,
              success: ((Session.Waitlist) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        var parameters: Alamofire.Parameters = [:]
        if let customerId = auth?.currentUser?.customer.id {
            parameters["customer"] = customerId
        }
        
        let request = requestBuilder.build(for: .sessionWaitlist(sessionId: session.id),
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
                    let waitlist = try self.decoder.decode(Session.Waitlist.self, from: data)
                    success?(waitlist)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
    
    func join(forSession session: Session,
              success: ((Session.Waitlist) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        updateWaitlist(withAction: "JOIN",
                       forSession: session,
                       success: success,
                       failure: failure)
    }
    
    func leave(forSession session: Session,
               success: ((Session.Waitlist) -> Void)?,
               failure: Controller.MethodFailure?) {
        
        updateWaitlist(withAction: "LEAVE",
                       forSession: session,
                       success: success,
                       failure: failure)
    }
    
    private func updateWaitlist(withAction action: String,
                                forSession session: Session,
                                success: ((Session.Waitlist) -> Void)?,
                                failure: Controller.MethodFailure?) {
        
        
        var parameters: Alamofire.Parameters = [
            "action" : action
        ]
        if let customerId = auth?.currentUser?.customer.id {
            parameters["customer"] = customerId
        }
        
        let request = requestBuilder.build(for: .sessionWaitlist(sessionId: session.id),
                                           method: .post,
                                           parameters: parameters,
                                           encoding: URLEncoding.httpBody,
                                           authentication: .userToken)
        
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(TeamupError.unknown, nil)
                    return
                }
                do {
                    let waitlist = try self.decoder.decode(Session.Waitlist.self, from: data)
                    success?(waitlist)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
}
