//
//  Request.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class Request {
    
    // MARK: Types
    
    enum Authentication {
        case none
        case apiToken
        case userToken
    }
    
    struct Body {
        
        enum Format {
            case json
            case formUrlEncoded
        }
        
        let data: [String : Any]
        let format: Format
    }
    
    // MARK: Properties
    
    let url: URL
    let headers: [String : Any]?
    let body: Data?
    
    // MARK: Init
    
    init(with url: URL,
         headers: [String : Any],
         body: Body? = nil) {
        self.url = url
        self.headers = headers
        self.body = body?.rawData
    }
}

extension Request.Body {
    
    var rawData: Data? {
        switch self.format {
            
        case .formUrlEncoded:
            return NSKeyedArchiver.archivedData(withRootObject: self.data)
            
        case .json:
            do {
                return try JSONEncoder().encode(data)
            } catch { return nil }
        }
    }
}
