//
//  Session+RegistrationDetails.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public extension Session {
    
    public struct RegistrationDetails: Codable {
        
        enum CodingKeys: String, CodingKey {
            case hasRequiredActions = "has_required_actions"
            case bookableReason = "bookable_reason"
            case isFull = "full"
            case hasAlreadyOccurred = "occurred"
            case isLeavableWithNoRefund = "leavable_no_refund"
            case isLeavable = "leavable"
            case isAttending = "attending"
            case isBookable = "bookable"
            case isBookableWithMembership = "bookable_with_membership"
            case waitlistIsJoinable = "waitlist_joinable"
        }
        
        let hasRequiredActions: Bool
        
        let bookableReason: String
        
        let isFull: Bool
        let hasAlreadyOccurred: Bool
        let isLeavableWithNoRefund: Bool
        let isLeavable: Bool
        let isAttending: Bool
        
        let isBookable: Bool
        let isBookableWithMembership: Bool
        
        let waitlistIsJoinable: Bool
    }
}
