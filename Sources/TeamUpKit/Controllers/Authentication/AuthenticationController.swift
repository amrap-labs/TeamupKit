//
//  AuthenticationController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthenticationController: Controller, Authentication {
    
    // MARK: Constants
    
    private struct KeychainKeys {
        static let user = "teamupUser"
    }
    
    // MARK: Properties
    
    private let apiToken: String
    private let keychain = KeychainSwift()
    
    private(set) var currentUser: User? {
        didSet {
            updateKeychain(for: currentUser)
        }
    }
    
    // MARK: Init
    
    init(with config: Config,
         requestBuilder: RequestBuilder,
         executor: RequestExecutor,
         apiToken: String) {
        self.apiToken = apiToken
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   executor: executor)
        
        currentUser = loadAuthenticatedUserIfAvailable()
    }
    
    // MARK: Requests
    
    func logIn(with email: String,
               password: String,
               success: ((User) -> Void)?,
               failure: MethodFailure?) {
        
        // ensure a user is not currently signed in
        guard currentUser == nil else {
            failure?(AuthenticationError.alreadySignedIn)
            return
        }
        
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
                    self.currentUser = user
                    
                    success?(user)
                } catch {
                    failure?(error)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
    
    func register(with email: String,
                  password: String,
                  success: ((User) -> Void)?,
                  failure: Controller.MethodFailure?) {
        
    }
}

// MARK: - Auth Management
private extension AuthenticationController {
    
    /// Update the keychain for a new user
    ///
    /// - Parameter user: The new user.
    func updateKeychain(for user: User?) {
        guard let user = user else {
            keychain.delete(KeychainKeys.user)
            return
        }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
            keychain.set(data, forKey: KeychainKeys.user)
        } catch {}
    }
    
    /// Attempt to load an authenticated user from the keychain
    ///
    /// - Returns: The currently authenticated user.
    func loadAuthenticatedUserIfAvailable() -> User? {
        guard let data = keychain.getData(KeychainKeys.user) else { return nil }
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            return nil
        }
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

extension AuthenticationController: RequestExecutorAuthResponder {
    
}
