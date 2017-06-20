//
//  Session+RegistrationDetails.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public extension Session {
    
    /// Registration details for a session.
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
            case checkoffStatus = "checkoff_status"
            case waitlistJoinableReason = "waitlist_joinable_reason"
            case price
            case waitlist
        }
        
        /// Whether the current user has the required actions for the session.
        let hasRequiredActions: Bool
        /// The check off status for the registration.
        let checkoffStatus: String?
        
        /// Whether the session is full.
        let isFull: Bool
        /// Whether the session has already occurred.
        let hasAlreadyOccurred: Bool
        /// Whether the session can be left without a refund.
        let isLeavableWithNoRefund: Bool
        /// Whether the session can be left.
        let isLeavable: Bool
        /// Whether the current user is attending the session.
        let isAttending: Bool
        
        /// Whether the session can be booked.
        let isBookable: Bool
        /// Whether the session can be booked with a membership.
        let isBookableWithMembership: Bool
        /// The reason the session is bookable or not.
        let bookableReason: String
        
        /// The waitlist for the session.
        let waitlist: Waitlist
        /// Whether the waitlist is joinable.
        let waitlistIsJoinable: Bool
        /// The reason why the waitlist is joinable or not.
        let waitlistJoinableReason: String
        
        /// Pricing details for the session.
        let price: PriceInfo
    }
}

// MARK: - Registration Pricing Details
public extension Session.RegistrationDetails {
    
    /// Collection of pricing data for a session.
    public struct PriceInfo: Codable {
        
        enum CodingKeys: String, CodingKey {
            case isSpecial = "is_special"
            case price
            case defaultPrice = "default_price"
        }
        
        /// Whether a special price is active.
        let isSpecial: Bool
        /// The price for this session.
        let price: Price
        /// The default price for this session.
        let defaultPrice: Price
    }
    
    /// Price data for a session.
    public struct Price: Codable {
        
        enum CodingKeys: String, CodingKey {
            case specialPricingId = "special_pricing_id"
            case currencyCode = "price_currency_code"
            case value = "price_decimal"
            case description
            case displayString = "price"
            case name
        }
        
        /// The identifier if special pricing is active.
        let specialPricingId: Int?
        /// The currency code for the price.
        let currencyCode: String
        /// The raw value of the price. (i.e. 10.00)
        let value: String
        /// The description for the price.
        let description: String?
        /// The display string of the price. (i.e. £10.00)
        let displayString: String?
        /// The name for the price.
        let name: String?
    }
}
