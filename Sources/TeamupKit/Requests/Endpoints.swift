//
//  Endpoints.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal enum Endpoint {
    
    // MARK: Auth
    case logIn
    case register(businessId: String)
    
    // MARK: Sessions
    case sessions
    case session(id: Int)
    case sessionWaitlist(sessionId: Int)
    case sessionRegistration(sessionId: Int)
    
    // MARK: Memberships
    case memberships
    case membership(id: Int)
    
    // MARK: Business
    case business(id: Int)
    
    // MARK: Instructors
    case instructors
    case instructor(id: Int)
}

internal extension Endpoint {
    
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
        case .sessionWaitlist(let sessionId):
            return "/sessions/\(sessionId)/waitlist"
        case .sessionRegistration(let sessionId):
            return "/sessions/\(sessionId)/register"
            
        case .memberships:
            return "/customermemberships"
        case .membership(let id):
            return "/customermemberships/\(id)"
            
        case .business(let id):
            return "/businesses/\(id)"
            
        case .instructors:
            return "/instructors"
        case .instructor(let id):
            return "/instructors/\(id)"
            
        }
    }
}

extension Endpoint: Equatable {
    
    static func ==(lhs: Endpoint, rhs: Endpoint) -> Bool {
        return lhs.path == rhs.path
    }
}
