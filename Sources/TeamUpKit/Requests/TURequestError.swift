//
//  TURequestError.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 25/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class TURequestError {
    
    public enum Cause: Error {
        case unknown
        
        case badRequest(reason: String)
    }
    
    let raw: Error
    let statusCode: TUResponse.StatusCode
    
    class var unknown: TURequestError {
        return TURequestError(raw: Cause.unknown, statusCode: .unknown)
    }
    
    // MARK: Init
    
    init(raw: Error?,
         statusCode: TUResponse.StatusCode,
         response: TUResponse?) {
        self.raw = raw ?? Cause.unknown
        self.statusCode = statusCode
        
    }
    
    convenience init(raw: Error?,
                     statusCode: TUResponse.StatusCode) {
        self.init(raw: raw,
                  statusCode: statusCode,
                  response: nil)
    }
}
