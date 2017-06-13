//
//  AuthenticationController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class AuthenticationController: Controller, Authentication {
    
    // MARK: Properties
    
    private let apiToken: String
    
    // MARK: Init
    
    init(with config: Config,
         requestBuilder: RequestBuilder,
         apiToken: String) {
        self.apiToken = apiToken
        super.init(with: config, requestBuilder: requestBuilder)
    }
    
    func logIn(with email: String, password: String) {
        let request = requestBuilder.build(for: .logIn, headers: .masterAuthenticated)
        
    }
}

extension AuthenticationController: RequestBuilderAuthProvider {
    
    func requestBuilder(requestUserAuthHeaders requestBuilder: RequestBuilder) -> [String : Any]? {
        return nil
    }
    
    func requestBuilder(requestMasterAuthHeaders requestBuilder: RequestBuilder) -> [String : Any]? {
        return ["Authorization" : "Token \(apiToken)"]
    }
}
