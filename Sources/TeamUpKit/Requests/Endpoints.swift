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
}

extension Endpoint {
    
    var path: String {
        switch self {
            
        case .logIn:
            return "/businesses/generic_login"
            
        case .register(let businessId):
            return "/businesses/\(businessId)/register"
        }
    }
}
