//
//  ApiConfig.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct ApiConfig {
    
    // MARK: Types
    
    public enum Version: String {
        case v1 = "v1"
        
        static var current: Version = .v1
    }
    
    // MARK: Keys
    
    private let baseUrlKey = "baseUrl"
    
    // MARK: Properties
    
    private let baseUrl: String
    private let version: Version
    private let token: String
    
    public var urlString: String {
        return "\(baseUrl)/\(version)"
    }
    public var url: URL {
        return URL(string: urlString)!
    }
    
    // MARK: Init
    
    init(with configDictionary: [String: Any],
         version: Version,
         token: String) {
        self.baseUrl = configDictionary[baseUrlKey] as! String
        self.version = version
        self.token = token
    }
}
