//
//  Response.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class TUResponse {
    
    // MARK: Types
    
    /// The status code of the repsonse
    ///
    /// - unknown: Unknown
    /// - OK: 200
    /// - unauthorized: 401
    /// - badRequest: 400
    /// - forbidden: 403
    /// - notFound: 404
    public enum StatusCode: Int {
        case unknown = -1
        
        case OK = 200
        case unauthorized = 401
        case badRequest = 400
        case forbidden = 403
        case notFound = 404
    }
    
    // MARK: Properties
    
    /// The raw URL response that was received.
    public let raw: URLResponse
    /// Data that was received as part of the response.
    public let data: Data?
    /// The status code of the response.
    public let statusCode: StatusCode
    /// Any error that was received as part of the response.
    public private(set) var error: TURequestError?
    
    /// Whether the response is a successful one.
    public var isSuccessful: Bool {
        return statusCode == .OK
    }
    
    // MARK: Init
    
    init?(with urlResponse: URLResponse?,
          and data: Data?,
          for request: TURequest,
          error: Error?) {
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            return nil
        }
        
        self.raw = httpUrlResponse
        self.data = data
        self.statusCode = StatusCode.init(rawValue: httpUrlResponse.statusCode) ?? .unknown
        
        if !isSuccessful {
            self.error = TURequestError(for: request,
                                        raw: error,
                                        statusCode: statusCode,
                                        response: self)
        }
    }
}
