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
    
    enum ContentType: String {
        case json = "application/json"
        case formUrlEncoded = "application/x-www-form-urlencoded"
    }
    
    struct Body {
        
        let data: [String : Any]
        fileprivate(set) var contentType: ContentType?
        
        init(_ data: [String : Any]) {
            self.data = data
        }
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
    let contentType: ContentType
    let headers: [String : String]
    let parameters: [String: Any]
    let body: Data?
    
    // MARK: Init
    
    init(with url: URL,
         method: Method,
         contentType: ContentType,
         headers: [String : String],
         parameters: [String : Any],
         body: Body? = nil) {
        self.url = url
        self.method = method
        self.contentType = contentType
        self.headers = headers
        self.parameters = parameters
        
        var body = body
        body?.contentType = contentType
        self.body = body?.rawData
    }
}

extension Request.Body {
    
    var rawData: Data? {
        guard let contentType = self.contentType else { return nil }
        switch contentType {
            
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
