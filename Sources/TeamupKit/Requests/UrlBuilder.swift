//
//  UrlBuilder.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal class UrlBuilder {
    
    // MARK: Properties
    
    /// The configuration for building Urls
    let config: Config
    
    // MARK: Init
    
    /// Create a URL Builder.
    ///
    /// - Parameter config: The configuration to use.
    init(with config: Config) {
        self.config = config
    }
    
    // MARK: Building
    
    /// Build a Url for an endpoint.
    ///
    /// - Parameter endpoint: The endpoint to build for.
    /// - Returns: The built URL.
    func build(for endpoint: Endpoint) -> URL {
        let baseUrl = config.api.url
        let path = endpoint.path
        return URL(string: "\(baseUrl)\(path)")!
    }
}
