//
//  Request.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

public class Request {
    
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
    
    // MARK: Properties
    
    /// The URL for the request.
    let url: URL
    /// The method to use.
    let method: Alamofire.HTTPMethod
    /// The headers to send.
    let headers: Alamofire.HTTPHeaders?
    /// The parameters to send.
    let parameters: Alamofire.Parameters?
    /// The encoding to use.
    let encoding: Alamofire.ParameterEncoding?
   
    /// The response to the request.
    private(set) var response: Response?
    
    /// Whether the request is currently in progress.
    private(set) var inProgress: Bool = false
    
    // MARK: Init
    
    init(with url: URL,
         method: Alamofire.HTTPMethod,
         headers: Alamofire.HTTPHeaders?,
         parameters: Alamofire.Parameters?,
         encoding: Alamofire.ParameterEncoding?) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
    
    // MARK: Actions
    
    func cancel() {
        
    }
    
    // MARK: Hashable
    
    var hashValue: Int {
        return 0
    }
}

extension Request: Equatable {
    
    public static func ==(lhs: Request, rhs: Request) -> Bool {
        return lhs.url == rhs.url
    }
}
