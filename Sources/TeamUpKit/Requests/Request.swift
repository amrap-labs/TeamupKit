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
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    // MARK: Properties
    
    let url: URL
    let method: Method
    let headers: [String : String]
    let parameters: [String: Any]
    let body: Data?
    
    // MARK: Init
    
    init(with url: URL,
         method: Method,
         headers: [String : String],
         parameters: [String : Any],
         body: Body? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.body = body?.rawData
    }
}

extension Request.Body {
    
    var rawData: Data? {
        switch self.format {
            
        case .formUrlEncoded:
            var bodyString = String()
            for (index, item) in data.enumerated() {
                if index != 0 {
                    bodyString.append("&")
                }
                bodyString.append("\(item.key)=\(item.value)")
            }
            return bodyString.data(using: .ascii, allowLossyConversion: false)
            
        case .json:
            do {
                return try JSONEncoder().encode(data)
            } catch { return nil }
        }
    }
}
