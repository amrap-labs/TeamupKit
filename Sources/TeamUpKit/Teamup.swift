//
//  Teamup.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class Teamup {
    
    // MARK: Properties
    
    let config: Config
    
    // MARK: Init
    
    public init(apiToken: String,
                providerId: String,
                apiVersion: ApiConfig.Version = .current) {
        self.config = Config(apiToken: apiToken,
                             providerId: providerId,
                             apiVersion: apiVersion)
    }
}
