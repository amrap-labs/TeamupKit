//
//  RequestBuilder.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol RequestBuilderAuthProvider: class {
    
    func requestBuilder(requestMasterAuthHeaders requestBuilder: RequestBuilder) -> [String : String]?
    
    func requestBuilder(requestUserAuthHeaders requestBuilder: RequestBuilder) -> [String : String]?
}

class RequestBuilder {
    
    // MARK: Properties
    
    let config: Config
    let urlBuilder: UrlBuilder
    
    weak var authProvider: RequestBuilderAuthProvider?
    
    // MARK: Init
    
    init(with config: Config, urlBuilder: UrlBuilder) {
        self.config = config
        self.urlBuilder = urlBuilder
    }
    
    // MARK: Building
    
    func build(for endpoint: Endpoint,
               method: Request.Method,
               headers: [String : String]? = nil,
               parameters: [String : Any]? = nil,
               body: Request.Body? = nil,
               authentication: Request.Authentication? = nil) -> Request {
        
        var headers: [String : String] = headers ?? [:]
        if let authentication = authentication, let authHeaders = generateAuthHeaders(for: authentication) {
            authHeaders.forEach({ headers[$0.key] = $0.value })
        }
        
        return Request(with: urlBuilder.build(for: endpoint),
                       method: method,
                       headers: headers,
                       parameters: parameters ?? [:],
                       body: body)
    }
    
    // MARK: Header Generation
    
    private func generateAuthHeaders(for authentication: Request.Authentication) -> [String : String]? {
        switch authentication {
        case .none:
            return nil
            
        case .apiToken:
            return authProvider?.requestBuilder(requestMasterAuthHeaders: self)
            
        case .userToken:
            return authProvider?.requestBuilder(requestUserAuthHeaders: self)
        }
    }
}
