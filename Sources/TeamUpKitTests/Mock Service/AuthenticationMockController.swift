//
//  AuthenticationMockController.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 26/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
@testable import TeamupKit

class AuthenticationMockController: AuthenticationController {
    
    var currentUser: User? {
        let customer = Customer(id: 12345, name: "Test User", emails: ["test@test.com"])
        return User(customer: customer, token: "TESTTOKEN", expires: "12313", success: true)
    }
    
    var isAuthenticated: Bool {
        return true
    }
    
    let config: Config
    let requestBuilder: RequestBuilder
    let executor: RequestExecutor
    
    init(with config: Config,
         requestBuilder: RequestBuilder,
         executor: RequestExecutor) {
        self.config = config
        self.requestBuilder = requestBuilder
        self.executor = executor
        
        requestBuilder.authProvider = self
    }
    
    func logIn(with email: String,
               password: String,
               success: ((User) -> Void)?,
               failure: Controller.MethodFailure?) {
        success?(currentUser!)
    }
    
    func register(with email: String,
                  password: String,
                  firstName: String,
                  surname: String,
                  success: ((User) -> Void)?,
                  failure: Controller.MethodFailure?) {
        
    }
    
    func signOut() {
        
    }
}

extension AuthenticationMockController: RequestBuilderAuthProvider {
    
    func requestBuilder(requestApiTokenAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        return ["Authorization" : "Token TESTTOKEN"]
    }
    
    func requestBuilder(requestUserTokenAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        return ["Authorization" : "Token TESTTOKEN"]
    }
}
