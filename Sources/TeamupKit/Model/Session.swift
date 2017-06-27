//
//  Session.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// A session that is occurring or has occurred.
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
    
    /// The identifier of the session.
    public let id: Int
    /// The name of the session.
    public let name: String
    /// The description of the session.
    public let description: String
    
    /// The venue that the session is occuring at.
    public let venue: Venue
    /// The business that is hosting the session.
    public let business: Business
    
    /// Web URL for the session details.
    public let detailUrl: URL
    /// Web URL for the session registration.
    public let registrationUrl: URL
    /// Details on registering the current user for the session.
    public let registrationDetails: RegistrationDetails?
    
    /// The total amount of registrations allowed for the session.
    public let occupancy: Int?
    /// The current attendance count for the session.
    public let attendanceCount: Int
    /// The type of the session.
    public let type: SessionType
    /// Whether the session is active.
    public let isActive: Bool
}
