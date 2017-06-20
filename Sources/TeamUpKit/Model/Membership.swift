//
//  Membership.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct Membership: Codable {
    
    // MARK: Types
    
    /// Status of a membership
    ///
    /// - active: Active.
    /// - cancelled: Cancelled.
    /// - inactive: Inactive.
    enum Status: String, Codable {
        case active = "ACTIVE"
        case cancelled = "CANCELLED"
        case inactive = "INACTIVE"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case membershipId = "membership"
        case expirationDate = "expiration_date"
        case maximumUsesOnClasses = "maximum_allowed_class_uses"
        case usesOnClasses = "class_uses"
        case maximumUsesOnCourses = "maximum_allowed_course_uses"
        case usesOnCourses = "course_uses"
        case usageInfo = "usage_info"
        case status
        case allowedUses = "allowed_uses"
        case currentUses = "uses"
    }
    
    // MARK: Properties
    
    /// The unique identifier of the membership.
    let id: Int
    /// The name of the membership.
    let name: String
    /// The membership id that can be used for registration.
    let membershipId: Int
    /// The expiration date of the membership.
    let expirationDate: String?
    
    /// The maximum number of times that this membership can be used on classes.
    let maximumUsesOnClasses: Int?
    /// The number of times this membership has been used on classes.
    let usesOnClasses: Int
    /// The maximum number of times that this membership can be used on courses.
    let maximumUsesOnCourses: Int?
    /// The number of times this membership has been used on courses.
    let usesOnCourses: Int
    /// Description of the usage information for this membership.
    let usageInfo: String
    
    /// The current status of this membership.
    let status: Status
    
    /// The allowed usage of this membership.
    let allowedUses: UsageInfo
    /// The current usage of this membership.
    let currentUses: UsageInfo
}

public extension Membership {
    
    /// Information on membership usage.
    public struct UsageInfo: Codable {
        
        /// Number of usages in a day.
        let day: Int?
        /// Number of usages in a week.
        let week: Int?
        /// Number of usages in a month.
        let month: Int?
        /// Number of usages in a year.
        let year: Int?
        /// The number of usages overall.
        let overall: Int?
    }
}
