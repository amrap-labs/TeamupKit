//
//  User.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct User: Codable {
    
    public let customer: Customer
    internal let token: String
    internal let expires: String
    internal let success: Bool
}
