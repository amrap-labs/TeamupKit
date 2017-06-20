//
//  Customer.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct Customer: Codable {
    
    /// Customer identifier.
    let id: Int
    /// Customer name.
    let name: String
    /// Associated emails for customer.
    let emails: [String]
}
