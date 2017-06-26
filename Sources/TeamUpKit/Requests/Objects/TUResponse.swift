//
//  Response.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class TUResponse {
    
    // MARK: Types
    
    enum StatusCode: Int {
        case unknown = -1
        
        case OK = 200
        case unauthorized = 401
        case badRequest = 400
        case forbidden = 403
        case notFound = 404
    }
    
    // MARK: Properties
    
    private let request: TURequest
    
    let raw: URLResponse
    let data: Data?
    let statusCode: StatusCode
    private(set) var error: TURequestError?
    
    var isSuccessful: Bool {
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
        self.request = request
        self.statusCode = StatusCode.init(rawValue: httpUrlResponse.statusCode) ?? .unknown
        
        if !isSuccessful {
            self.error = TURequestError(raw: error,
                                        statusCode: statusCode,
                                        response: self)
        }
    }
}
