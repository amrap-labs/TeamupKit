//
//  User.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct User: Codable {
    
    let customer: Customer
    let token: String
    let expires: String
    let success: Bool
}
