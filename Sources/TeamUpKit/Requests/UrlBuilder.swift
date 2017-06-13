//
//  UrlBuilder.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class UrlBuilder {
    
    // MARK: Properties
    
    let config: Config
    
    // MARK: Init
    
    init(with config: Config) {
        self.config = config
    }
    
    // MARK: Building
    
    func build(for endpoint: Endpoint) -> URL {
        let baseUrl = config.api.url
        let path = endpoint.path
        return URL(string: "\(baseUrl)\(path)")!
    }
}
