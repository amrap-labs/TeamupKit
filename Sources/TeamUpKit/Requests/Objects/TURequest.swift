//
//  TURequest.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class TURequest {
    
    // MARK: Types
    
    public enum Authentication {
        case none
        case apiToken
        case userToken
    }
    
    public enum ContentType: String {
        case json = "application/json"
        case formUrlEncoded = "application/x-www-form-urlencoded"
    }
    
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    // MARK: Properties
    
    let url: URL
    let method: Method
    let contentType: ContentType
    let headers: Headers?
    let parameters: Parameters?
    let body: Data?
    
    // MARK: Init
    
    init(with url: URL,
         method: Method,
         contentType: ContentType,
         headers: Headers?,
         parameters: Parameters?,
         body: Body?) {
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

extension TURequest: Equatable {
    
    public static func ==(lhs: TURequest, rhs: TURequest) -> Bool {
        return lhs.url == rhs.url
    }
}
