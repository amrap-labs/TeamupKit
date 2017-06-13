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
    
    private let config: Config
    
    public var auth: Authentication?
    
    // MARK: Init
    
    public init(apiToken: String,
                providerId: String,
                apiVersion: ApiConfig.Version = .current) {
        self.config = Config(providerId: providerId,
                             apiVersion: apiVersion)
        
    }
}
