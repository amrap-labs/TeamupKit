//
//  Response.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 14/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class Response {
    
    // MARK: Types
    
    public typealias StatusCode = Int
    
    // MARK: Properties
    
    /// The raw response.
    let raw: URLResponse
    /// The status code of the response.
    let statusCode: StatusCode
    /// The data included with the response.
    let data: Data?
    /// The error included with the response.
    let error: Error?
    
    /// Whether the response is a successful one.
    var isSuccessful: Bool {
        return error == nil && 200 ... 299 ~= statusCode
    }
    
    init(rawResponse: URLResponse,
         statusCode: Int,
         data: Data?,
         error: Error?) {
        self.raw = rawResponse
        self.statusCode = statusCode
        self.data = data
        self.error = error
    }
}

