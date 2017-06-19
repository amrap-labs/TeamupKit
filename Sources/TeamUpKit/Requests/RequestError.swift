//
//  Request+Errors.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 18/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public enum RequestError: Error {
    case unknown
    
    case badRequest(reason: String)
}
