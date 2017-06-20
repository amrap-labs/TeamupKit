//
//  Venue.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct Venue: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case timezone
        case latitude = "lat"
        case longitude = "lng"
        case description
    }
    
    let id: Int
    let name: String
    let address: String
    let timezone: String
    let latitude: Double
    let longitude: Double
    let description: String
}
