//
//  CommsConfig.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct CommsConfig {
    
    // MARK: Types
    
    /// The version of the Teamup API to use
    public enum Version: String {
        
        /// Version 1.0
        case v1 = "v1"
        
        /// The latest version of the API
        static public var current: Version = .v1
    }
    
    // MARK: Keys
    
    private let baseUrlKey = "baseUrl"
    
    // MARK: Properties
    
    /// The base url for the Teamup service.
    private let baseUrl: String
    /// The version of the API that is being used.
    private let version: Version
    
    /// The URL for the Teamup service.
    public let url: URL
    
    // MARK: Init
    
    init(with configDictionary: [String: Any],
         version: Version) {
        self.baseUrl = configDictionary[baseUrlKey] as! String
        self.version = version
        
        let urlString = "\(baseUrl)/\(version)"
        self.url = URL(string: urlString)!
    }
}
