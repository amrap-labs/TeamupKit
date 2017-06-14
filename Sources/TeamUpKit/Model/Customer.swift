//
//  Customer.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct Customer: Codable {
    
    let id: Int
    let name: String
    let emails: [String]
}
