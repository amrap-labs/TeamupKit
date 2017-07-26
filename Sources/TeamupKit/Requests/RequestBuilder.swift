//
//  RequestBuilder.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

internal protocol RequestBuilderAuthProvider: class {
    
    /// The request builder requires headers for authorizing via the application API token.
    ///
    /// - Parameter requestBuilder: The request builder.
    /// - Returns: The application API token headers.
    func requestBuilder(requestApiTokenAuthHeaders requestBuilder: RequestBuilder) -> [String : String]?
    
    /// The request builder requires headers for authorizing via a user's access token.
    ///
    /// - Parameter requestBuilder: The request builder.
    /// - Returns: The user's access token headers.
    func requestBuilder(requestUserTokenAuthHeaders requestBuilder: RequestBuilder) -> [String : String]?
}

internal class RequestBuilder {
    
    // MARK: Properties
    
    /// The configuration for TeamUp.
    let config: Config
    /// The URL Builder.
    let urlBuilder: UrlBuilder
    
    /// The object that acts as a provider for authentication headers.
    weak var authProvider: RequestBuilderAuthProvider?
    
    // MARK: Init
    
    /// Create a Request Builder.
    ///
    /// - Parameters:
    ///   - config: The configuration to use.
    ///   - urlBuilder: The URL Builder to use.
    init(with config: Config, urlBuilder: UrlBuilder) {
        self.config = config
        self.urlBuilder = urlBuilder
    }
    
    // MARK: Building
    
    /// Build a request for a specified endpoint.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint for the request.
    ///   - method: The method type to use.
    ///   - contentType: The type of content to request.
    ///   - headers: The headers to send.
    ///   - parameters: The paramters to send.
    ///   - body: The body to send.
    ///   - authentication: The type of authentication to use.
    /// - Returns: The request.
    func build(for endpoint: Endpoint,
               method: Alamofire.HTTPMethod,
               headers: Alamofire.HTTPHeaders? = nil,
               parameters: Alamofire.Parameters? = nil,
               encoding: Alamofire.ParameterEncoding? = nil,
               authentication: Request.Authentication? = nil) -> Request {
        
        return build(for: urlBuilder.build(for: endpoint),
                     method: method,
                     headers: headers,
                     parameters: parameters,
                     encoding: encoding,
                     authentication: authentication)
    }
    
    func build(for url: URL,
               method: Alamofire.HTTPMethod,
               headers: Alamofire.HTTPHeaders? = nil,
               parameters: Alamofire.Parameters? = nil,
               encoding: Alamofire.ParameterEncoding? = nil,
               authentication: Request.Authentication? = nil) -> Request {
        
        var headers: Alamofire.HTTPHeaders = headers ?? [:]
        if let authentication = authentication, let authHeaders = generateAuthHeaders(for: authentication) {
            authHeaders.forEach({ headers[$0.key] = $0.value })
        }
        
        return ExecutableRequest(with: url,
                                 method: method,
                                 headers: headers,
                                 parameters: parameters,
                                 encoding: encoding)
    }
    
    // MARK: Header Generation
    
    private func generateAuthHeaders(for authentication: Request.Authentication) -> [String : String]? {
        switch authentication {
        case .none:
            return nil
            
        case .apiToken:
            return authProvider?.requestBuilder(requestApiTokenAuthHeaders: self)
            
        case .userToken:
            return authProvider?.requestBuilder(requestUserTokenAuthHeaders: self)
        }
    }
}
