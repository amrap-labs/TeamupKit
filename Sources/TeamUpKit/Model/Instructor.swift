//
//  Instructor.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 21/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct Instructor: Codable {
    
    /// The Id of the instructor.
    let id: Int
    /// The name of the instructor.
    let name: String
    /// Description about the instructor.
    let description: String
    /// URL for the instructor's picture.
    let picture: URL
}
