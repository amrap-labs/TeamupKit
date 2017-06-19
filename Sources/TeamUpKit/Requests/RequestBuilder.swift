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
               contentType: Request.ContentType,
               headers: Request.Headers? = nil,
               parameters: Request.Parameters? = nil,
               body: Request.Body? = nil,
               authentication: Request.Authentication? = nil) -> Request {
        
        var headers: Request.Headers = headers ?? Request.Headers()
        if let authentication = authentication, let authHeaders = generateAuthHeaders(for: authentication) {
            authHeaders.forEach({ headers.add($0.value, for: $0.key) })
        }
        
        return Request(with: urlBuilder.build(for: endpoint),
                       method: method,
                       contentType: contentType,
                       headers: headers,
                       parameters: parameters,
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
