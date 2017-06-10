//
//  Config.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal class Config {
    
    // MARK: Properties
    
    let providerId: String
    private(set) var api: ApiConfig!
    
    private var configDictionary: [String : Any] {
        let plist = Bundle(for: type(of: self)).path(forResource: "Config", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: plist)!
        return dictionary as! [String : Any]
    }
    
    init(providerId: String,
         apiVersion: ApiConfig.Version) {
        self.providerId = providerId
        self.api = ApiConfig(with: configDictionary,
                             version: apiVersion)
    }
}
