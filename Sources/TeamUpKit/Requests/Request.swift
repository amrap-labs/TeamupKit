//
//  Request.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class Request {
    
    enum Headers {
        case masterAuthenticated
        case userAuthenticated
        case custom(headers: [String : Any])
    }
    
    // MARK: Properties
    
    let url: URL
    
    // MARK: Init
    
    init(with url: URL,
         headers: [String : Any]? = nil) {
        self.url = url
    }
}

