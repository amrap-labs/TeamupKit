//
//  User.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let customer: Customer
    let token: String
    let expires: Date
    let success: Bool
}
