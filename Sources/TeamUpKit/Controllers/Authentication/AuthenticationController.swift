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
    
    private(set) var currentUser: User?
    
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
    
    // MARK: Requests
    
    func logIn(with email: String,
               password: String,
               success: ((User) -> Void)?,
               failure: MethodFailure?) {
        
        let body = Request.Body(["email" : email,
                                 "password" : password])
        
        let request = requestBuilder.build(for: .logIn,
                                           method: .post,
                                           contentType: .formUrlEncoded,
                                           body: body,
                                           authentication: .apiToken)
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(RequestError.unknown)
                    return
                }
                do {
                    let user = try self.decoder.decode(User.self, from: data)
                    self.authenticate(newUser: user)
                    
                    success?(user)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}

// MARK: - Auth Management
private extension AuthenticationController {
    
    func authenticate(newUser: User) {
        self.currentUser = newUser
    }
}

extension AuthenticationController: RequestBuilderAuthProvider {
    
    func requestBuilder(requestUserAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        guard let currentUser = self.currentUser else { return nil }
        return ["Authorization"  : "Token \(currentUser.token)"]
    }
    
    func requestBuilder(requestMasterAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        return ["Authorization" : "Token \(apiToken)"]
    }
}
