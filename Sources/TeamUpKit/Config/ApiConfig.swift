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
    
    public let urlString: String
    public let url: URL
    
    // MARK: Init
    
    init(with configDictionary: [String: Any],
         version: Version) {
        self.baseUrl = configDictionary[baseUrlKey] as! String
        self.version = version
        
        self.urlString = "\(baseUrl)/\(version)"
        self.url = URL(string: urlString)!
    }
}
