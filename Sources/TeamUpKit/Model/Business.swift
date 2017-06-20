//
//  Business.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct Business: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case latitude = "lat"
        case longitude = "lng"
        case storeUrl = "store_url"
    }
    
    /// Identifier of the business.
    public let id: Int
    /// Name of the business.
    public let name: String
    /// Address of the business.
    public let address: String
    /// Latitude of the business.
    public let latitude: Double
    /// Longitude of the business.
    public let longitude: Double
    /// URL for business store.
    public let storeUrl: URL
}
