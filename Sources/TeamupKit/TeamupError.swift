//
//  TUError.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 04/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

enum TeamupError: Error {
    
    enum Paging: Error {
        
        case pageNotFound
    }
    
    enum Comms: Error {
        
        case unknown
    }
}

extension TeamupError {
    
    static var unknown: Error {
        return Comms.unknown
    }
}
