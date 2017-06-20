//
//  SessionsController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 19/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class SessionsController: AuthenticatedController, Sessions {
    
    // MARK: Properties
    
    private let sessionsDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}

// MARK: - Session loading
extension SessionsController {
    
    func load(between startDate: Date,
              and endDate: Date,
              success: ((ResultsPage<Session>) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        load(between: startDate, and: endDate,
             includeRegistrationDetails: true,
             includeNonActive: false,
             page: nil,
             success: success, failure: failure)
    }
    
    func load(between startDate: Date,
              and endDate: Date,
              includeRegistrationDetails: Bool,
              includeNonActive: Bool,
              page: Int?,
              success: ((ResultsPage<Session>) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(config.business.businessId, for: "business")
        parameters.set(auth?.currentUser?.customer.id, for: "customer")
        parameters.set(includeRegistrationDetails, for: "include_registration_details")
        parameters.set(includeNonActive, for: "include_non_active")
        parameters.set(page, for: "page")
        parameters.set(sessionsDateFormatter.string(from: startDate), for: "start_date")
        parameters.set(sessionsDateFormatter.string(from: startDate), for: "end_date")
        
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
                    success?(sessions)
                } catch {
                    failure?(error)
                }
        })
        { (request, response, error) in
            failure?(error)
        }
    }
    
    func load(sessionWithId id: Int,
              includeRegistrationDetails: Bool,
              success: ((Session) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(auth?.currentUser?.customer.id, for: "customer")
        parameters.set(includeRegistrationDetails, for: "include_registration_details")
        
        let request = requestBuilder.build(for: .session(id: id),
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
                    let session = try self.decoder.decode(Session.self, from: data)
                    success?(session)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}

// MARK: - Session Waitlist loading
extension SessionsController {
    
    func loadWaitlist(forSession session: Session,
                      success: ((Session.Waitlist) -> Void)?,
                      failure: Controller.MethodFailure?) {
        
        var parameters = Request.Parameters()
        parameters.set(auth?.currentUser?.customer.id, for: "customer")
        
        let request = requestBuilder.build(for: .waitlist(sessionId: session.id),
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
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}
