//
//  Config.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal class Config {
    
    // MARK: Keys
    
    private let configKey = "Config"
    
    // MARK: Properties
    
    let providerId: String
    private(set) var api: ApiConfig!
    
    private var configDictionary: [String : Any] {
        let infoPlist = Bundle(for: type(of: self)).infoDictionary
        return infoPlist![configKey] as! [String : Any]
    }
    
    init(apiToken: String,
         providerId: String,
         apiVersion: ApiConfig.Version) {
        self.providerId = providerId
        self.api = ApiConfig(with: configDictionary,
                             version: apiVersion,
                             token: apiToken)
    }
}
