//
//  WaitlistsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class WaitlistsApiController: AuthenticatedController, WaitlistsController {
    
    func load(forSession session: Session,
              success: ((Session.Waitlist) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(auth?.currentUser?.customer.id, for: "customer")
        
        let request = requestBuilder.build(for: .sessionWaitlist(sessionId: session.id),
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
                    let waitlist = try self.decoder.decode(Session.Waitlist.self, from: data)
                    success?(waitlist)
                } catch {
                    failure?(RequestError(with: error))
                }
        }) { (request, response, error) in
            failure?(error)
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
        var body = Request.Body()
        body.add(auth?.currentUser?.customer.id, for: "customer")
        body.add(action, for: "action")
        
        let request = requestBuilder.build(for: .sessionWaitlist(sessionId: session.id),
                                           method: .post,
                                           contentType: .formUrlEncoded,
                                           body: body,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(RequestError.unknown)
                    return
                }
                do {
                    let waitlist = try self.decoder.decode(Session.Waitlist.self, from: data)
                    success?(waitlist)
                } catch {
                    failure?(RequestError(with: error))
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}
