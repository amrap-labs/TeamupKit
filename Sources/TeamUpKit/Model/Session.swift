//
//  Session.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct Session: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case venue
        case business
        case detailUrl = "detail_url"
        case registrationUrl = "registration_url"
        case occupancy
        case attendanceCount = "attendance_count"
        case type
        case registrationDetails = "registration_details"
        case isActive = "active"
    }
    
    public let id: Int
    public let name: String
    public let description: String
    public let venue: Venue
    public let business: Business
    public let detailUrl: URL
    public let registrationUrl: URL
    public let occupancy: Int?
    public let attendanceCount: Int
    public let type: SessionType
    public let registrationDetails: RegistrationDetails?
    public let isActive: Bool
}
