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
         executor: RequestExecutor,
         apiToken: String) {
        self.apiToken = apiToken
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   executor: executor)
    }
    
    func logIn(with email: String, password: String) {
        let body = Request.Body(data: ["email" : email,
                                       "password" : password],
                                format: .formUrlEncoded)
        
        let request = requestBuilder.build(for: .logIn,
                                           method: .post,
                                           body: body,
                                           authentication: .apiToken)
        requestExecutor.execute(request: request)
    }
}

extension AuthenticationController: RequestBuilderAuthProvider {
    
    func requestBuilder(requestUserAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        return nil
    }
    
    func requestBuilder(requestMasterAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        return ["Authorization" : "Token \(apiToken)"]
    }
}
