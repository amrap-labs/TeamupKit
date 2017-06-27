//
//  TURequest+Components.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 26/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

// MARK: - TURequest Components
public extension TURequest {
    
    /// The body object of the request.
    public struct Body {
        
        /// The data contained within the body.
        public private(set) var data: [String : Any]
        /// The type of content in the body.
        public internal(set) var contentType: ContentType?
        
        // MARK: Init
        
        internal init(_ data: [String : Any]) {
            self.data = data
        }
        
        internal init() {
            self.init([:])
        }
        
        // MARK: Data
        
        internal mutating func add(_ value: Any?, for key: String) {
            guard let value = value else { return }
            data[key] = value
        }
    }
    
    /// The headers that are sent with the request.
    public struct Headers {
        
        /// The data contained within the headers.
        public private(set) var data: [String : String] = [:]
        
        /// The number of headers in the request.
        public var count: Int {
            return data.count
        }
        
        // MARK: Data
        
        internal mutating func add(_ value: String?, for key: String) {
            guard let value = value else { return }
            data[key] = value
        }
    }
    
    /// The parameters that are sent with the request.
    public struct Parameters {
        
        /// The data contained within the parameters.
        public private(set) var data: [String : Any] = [:]
        
        /// The number of parameters in the request.
        public var count: Int {
            return data.count
        }
        
        // MARK: Data
        
        internal mutating func set(_ value: Any?, for key: String) {
            guard let value = value else { return }
            data[key] = value
        }
    }
}

internal extension TURequest.Body {
    
    /// The raw body data encoded in the specified format.
    var rawData: Data? {
        guard let contentType = self.contentType else { return nil }
        switch contentType {
            
        case .formUrlEncoded:
            var bodyString = String()
            for (index, item) in data.enumerated() {
                if index != 0 {
                    bodyString.append("&")
                }
                bodyString.append("\(item.key)=\(item.value)")
            }
            return bodyString.data(using: .ascii, allowLossyConversion: false)
            
        case .json:
            do {
                return try JSONEncoder().encode(data)
            } catch { return nil }
        }
    }
}
