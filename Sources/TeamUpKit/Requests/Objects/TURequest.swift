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
    
    /// The type of authentication for a request.
    ///
    /// - none: Use no authentication.
    /// - apiToken: Use the API token provided to Teamup.
    /// - userToken: Use the currently authenticated user's token.
    public enum Authentication {
        case none
        case apiToken
        case userToken
    }
    
    /// The type of content for a request.
    ///
    /// - json: JSON
    /// - formUrlEncoded: FormURL-Encoded
    public enum ContentType: String {
        case json = "application/json"
        case formUrlEncoded = "application/x-www-form-urlencoded"
    }
    
    /// Request Method type.
    ///
    /// - get: GET
    /// - post: POST
    /// - patch: PATCH
    /// - delete: DELETE
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    // MARK: Properties
    
    /// The URL for the request to hit.
    public let url: URL
    /// The method for the request to use.
    public let method: Method
    /// The content type to request for.
    public let contentType: ContentType
    /// Any headers that are part of the request.
    public let headers: Headers?
    /// Any parameters that are part of the request.
    public let parameters: Parameters?
    /// Any body data that is part of the request.
    public let body: Data?
    
    // MARK: Init
    
    /// Initialize a new request.
    ///
    /// - Parameters:
    ///   - url: The url for the request.
    ///   - method: The method to use.
    ///   - contentType: The type of content to request.
    ///   - headers: Headers to send.
    ///   - parameters: Parameters to send.
    ///   - body: Body data to send.
    internal init(with url: URL,
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
