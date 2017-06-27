//
//  Session+Waitlist.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public extension Session {
    
    /// Waitlist for a session.
    public struct Waitlist: Codable {
        
        enum CodingKeys: String, CodingKey {
            case reserved
            case position = "waitlist_position"
            case isActive = "is_active"
            case isOnWaitlist = "on_waitlist"
            case size
        }
        
        /// Whether the current user has reserved.
        let reserved: Bool
        /// The position on the waitlist.
        let position: Bool
        /// Whether the waitlist is active.
        let isActive: Bool
        /// Whether the current user is on the waitlist.
        let isOnWaitlist: Bool
        /// The size of the waitlist.
        let size: Int?
    }
}
