//
//  SessionsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 19/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class SessionsApiController: AuthenticatedController, SessionsController {
    
    // MARK: Properties
    
    private var registrationsController: RegistrationsApiController
    var registrations: RegistrationsController {
        return registrationsController
    }
    
    private var waitlistsController: WaitlistsApiController
    var waitlists: WaitlistsController {
        return waitlistsController
    }
    
    private let sessionsDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    // MARK: Init
    
    override init(with config: Config,
                  requestBuilder: RequestBuilder,
                  executor: RequestExecutor,
                  auth: AuthenticationController) {
        self.registrationsController = RegistrationsApiController(with: config,
                                                                  requestBuilder: requestBuilder,
                                                                  executor: executor,
                                                                  auth: auth)
        self.waitlistsController = WaitlistsApiController(with: config,
                                                          requestBuilder: requestBuilder,
                                                          executor: executor,
                                                          auth: auth)
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   executor: executor,
                   auth: auth)
    }
}

// MARK: - Session loading
extension SessionsApiController {
    
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
        
        var parameters = TURequest.Parameters()
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
        
        var parameters = TURequest.Parameters()
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
