//
//  SessionType.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct SessionType: Codable {
    
    /// Identifier of the session type.
    let id: Int
    /// Session type name.
    let name: String
    /// Session type description.
    let description: String
}
