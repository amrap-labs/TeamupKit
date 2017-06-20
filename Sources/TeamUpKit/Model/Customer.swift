//
//  Customer.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct Customer: Codable {
    
    /// Customer identifier.
    public let id: Int
    /// Customer name.
    public let name: String
    /// Associated emails for customer.
    public let emails: [String]
}
