//
//  Request.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class Request {
    
    // MARK: Types
    
    public enum Authentication {
        case none
        case apiToken
        case userToken
    }
    
    public enum ContentType: String {
        case json = "application/json"
        case formUrlEncoded = "application/x-www-form-urlencoded"
    }
    
    public struct Body {
        
        public private(set) var data: [String : Any]
        public fileprivate(set) var contentType: ContentType?
        
        public init(_ data: [String : Any]) {
            self.data = data
        }
        
        public init() {
            self.init([:])
        }
        
        public mutating func add(_ value: Any?, for key: String) {
            guard let value = value else { return }
            data[key] = value
        }
    }
    
    public struct Headers {
        
        public private(set) var data: [String : String] = [:]
        
        public var count: Int {
            return data.count
        }
        
        public mutating func add(_ value: String?, for key: String) {
            guard let value = value else { return }
            data[key] = value
        }
    }
    
    public struct Parameters {
        
        public private(set) var data: [String : Any] = [:]
        
        public var count: Int {
            return data.count
        }
        
        public mutating func set(_ value: Any?, for key: String) {
            guard let value = value else { return }
            data[key] = value
        }
    }
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    // MARK: Properties
    
    let url: URL
    let method: Method
    let contentType: ContentType
    let headers: Headers?
    let parameters: Parameters?
    let body: Data?
    
    // MARK: Init
    
    init(with url: URL,
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

extension Request.Body {
    
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

extension Request: Equatable {
    
    public static func ==(lhs: Request, rhs: Request) -> Bool {
        return lhs.url == rhs.url
    }
}
