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
    public let customer: Customer
    
    /// The access token for the user.
    internal let token: String
    /// The expiry date of the token.
    internal let expires: String
    /// Whether the user was successfully authenticated.
    internal let success: Bool
}
