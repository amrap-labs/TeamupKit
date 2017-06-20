//
//  Endpoints.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

enum Endpoint {
    
    // MARK: Auth
    case logIn
    case register(businessId: String)
    
    // MARK: Sessions
    case sessions
    case session(id: Int)
    case waitlist(sessionId: Int)
    case registration(sessionId: Int)
}

extension Endpoint {
    
    var path: String {
        switch self {
            
        case .logIn:
            return "/businesses/generic_login"
        case .register(let businessId):
            return "/businesses/\(businessId)/register"
            
        case .sessions:
            return "/sessions"
        case .session(let id):
            return "/sessions/\(id)"
        case .waitlist(let sessionId):
            return "/sessions/\(sessionId)/waitlist"
        case .registration(let sessionId):
            return "/sessions/\(sessionId)/register"
            
        }
    }
}
