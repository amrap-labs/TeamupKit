//
//  Session.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct Session: Codable {
    
    let id: Int
    let name: String
    let description: String
    let venue: Venue
}
