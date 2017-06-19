//
//  Response.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class Response {
    
    // MARK: Types
    
    enum StatusCode: Int {
        case unknown = -1
        
        case OK = 200
        case unauthorized = 401
        case badRequest = 400
        case notFound = 404
    }
    
    // MARK: Properties
    
    private let request: Request
    
    let raw: URLResponse
    let data: Data?
    let statusCode: StatusCode
    private(set) var error: Error?
    
    var isSuccessful: Bool {
        return statusCode == .OK
    }
    
    // MARK: Init
    
    init?(with urlResponse: URLResponse?,
          and data: Data?,
          for request: Request,
          error: Error?) {
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            return nil
        }
        
        self.raw = httpUrlResponse
        self.data = data
        self.request = request
        self.error = error
        self.statusCode = StatusCode.init(rawValue: httpUrlResponse.statusCode) ?? .unknown
        
        if !isSuccessful && error == nil {
            self.error = generateRequestError(for: statusCode)
        }
    }
    
    // MARK: Error generation
    
    private func generateRequestError(for statusCode: StatusCode?) -> RequestError {
        guard let statusCode = statusCode else { return .unknown }
        var reason: String = "unknown"
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            reason = dataString
        }
        
        switch statusCode {
            
        case .badRequest:
            return .badRequest(reason: reason)
            
        default:
            return .unknown
        }
    }
}
