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
    
    func loadSessions(between startDate: Date,
                      and endDate: Date,
                      includeRegistrationDetails: Bool,
                      includeNonActive: Bool,
                      success: (() -> Void)?,
                      failure: Controller.MethodFailure?) {
        
        let request = requestBuilder.build(for: .sessions,
                                           method: .get,
                                           contentType: .json,
                                           authentication: .userToken)
        requestExecutor.execute(request: request,
                                success:
        { (request, response, data) in
            print(response)
        })
        { (request, response, error) in
            
        }
    }
}
