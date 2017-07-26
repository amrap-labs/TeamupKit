//
//  SessionsApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 19/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

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
        
        var parameters: Alamofire.Parameters = [
            "business" : config.business.businessId,
            "include_registration_details" : includeRegistrationDetails,
            "include_non_active" : includeNonActive,
            "start_date" : sessionsDateFormatter.string(from: startDate),
            "end_date" : sessionsDateFormatter.string(from: endDate)
        ]
        if let page = page {
            parameters["page"] = page
        }
        if let customerId = auth?.currentUser?.customer.id {
            parameters["customer"] = customerId
        }
        
        let request = requestBuilder.build(for: .sessions,
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
                    let sessions = try self.decoder.decode(ResultsPage<Session>.self, from: data)
                    success?(sessions)
                } catch {
                    failure?(error, nil)
                }
        })
        { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
    
    func load(sessionWithId id: Int,
              includeRegistrationDetails: Bool,
              success: ((Session) -> Void)?,
              failure: Controller.MethodFailure?) {
        
        var parameters: Alamofire.Parameters = [
            "include_registration_details" : includeRegistrationDetails
        ]
        if let customerId = auth?.currentUser?.customer.id {
            parameters["customer"] = customerId
        }
        
        let request = requestBuilder.build(for: .session(id: id),
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
                    let session = try self.decoder.decode(Session.self, from: data)
                    success?(session)
                } catch {
                    failure?(error, nil)
                }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
        }
    }
}
