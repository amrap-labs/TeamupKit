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
    private var requestBuilder: RequestBuilder!
    
    public var auth: Authentication!
    
    // MARK: Init
    
    public init(apiToken: String,
                providerId: String,
                apiVersion: ApiConfig.Version = .current) {
        self.config = Config(providerId: providerId,
                             apiVersion: apiVersion)
        initComponents(with: config)
        initControllers(with: config,
                        requestBuilder: requestBuilder)
    }
    
    private func initComponents(with config: Config) {
        
        self.requestBuilder = RequestBuilder(with: config,
                                             urlBuilder: UrlBuilder(with: config))
    }
    
    private func initControllers(with config: Config,
                                 requestBuilder: RequestBuilder) {
        
        let authController = AuthenticationController(with: config, requestBuilder: requestBuilder)
        requestBuilder.authProvider = authController
        self.auth = authController
    }
}
