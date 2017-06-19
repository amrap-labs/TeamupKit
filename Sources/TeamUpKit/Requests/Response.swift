//
//  Response.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class Response {
    
    // MARK: Types
    
    enum StatusCode: Int {
        case OK = 200
        case unauthorized = 401
    }
    
    // MARK: Properties
    
    let raw: URLResponse
    let statusCode: StatusCode?
    
    var isSuccessful: Bool {
        return statusCode == .OK
    }
    
    // MARK: Init
    
    init?(with urlResponse: URLResponse?) {
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            return nil
        }
        
        self.raw = httpUrlResponse
        self.statusCode = StatusCode.init(rawValue: httpUrlResponse.statusCode)
    }
}
