//
//  User.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// A user that is associated with a customer.
public struct User: Codable {
    
    /// The customer associated with the user.
    public let customer: Customer?
    /// The local unique identifier for the user.
    public internal(set) var identifier: String!
    
    /// The access token for the user.
    internal let token: String?
    /// The expiry date of the token.
    internal let expires: String?
    /// Whether the user was successfully authenticated.
    internal let success: Bool?
    
    // MARK: Local User
    
    private init(identifier: String) {
        self.customer = nil
        self.identifier = identifier
        self.token = nil
        self.expires = nil
        self.success = nil
    }
    
    internal init(customer: Customer,
                 token: String,
                 expires: String,
                 success: Bool) {
        self.customer = customer
        self.identifier = UUID().uuidString
        self.token = token
        self.expires = expires
        self.success = success
    }
    
    static var local: User {
        return User(identifier: UUID().uuidString)
    }
}
