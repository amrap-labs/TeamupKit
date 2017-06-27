//
//  Venue.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct Venue: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case timezone
        case latitude = "lat"
        case longitude = "lng"
        case description
    }
    
    /// Identifier of the venue.
    public let id: Int
    /// Name of the venue.
    public let name: String
    /// Address of the venue.
    public let address: String
    /// Timezone that the venue is in.
    public let timezone: String
    /// Latitude of the venue.
    public let latitude: Double
    /// Longitude of the venue.
    public let longitude: Double
    /// Description of the venue.
    public let description: String
}
