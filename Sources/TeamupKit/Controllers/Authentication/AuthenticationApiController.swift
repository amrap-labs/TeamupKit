//
//  AuthenticationApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import KeychainSwift
import Alamofire

class AuthenticationApiController: ApiController, AuthenticationController {
    
    // MARK: Constants
    
    private struct KeychainKeys {
        static let user = "teamupUser"
        static let userAuthData = "teamupUserAuthData"
    }
    
    private struct UserAuthData: Codable {
        let password: String
    }
    
    // MARK: Properties
    
    private let apiToken: String
    private let keychain = KeychainSwift()
    
    private(set) var currentUser: User?
    private var currentUserAuthData: UserAuthData?
    
    private var loginRequest: Request?
    
    var isAuthenticated: Bool {
        return currentUser != nil
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
        
        let requestExecutor = executor
        requestBuilder.authProvider = self
        requestExecutor.authResponder = self
        
        currentUser = loadAuthenticatedUserIfAvailable()
        currentUserAuthData = loadUserAuthenticationDataIfAvailable()
    }
    
    // MARK: Authentication
    
    func logIn(email: String,
               password: String,
               success: ((User) -> Void)?,
               failure: Controller.MethodFailure?) {
        performLogIn(with: email,
                     password: password,
                     success: success,
                     failure: failure,
                     force: false)
    }
    
    func register(email: String,
                  password: String,
                  firstName: String,
                  surname: String,
                  success: ((User) -> Void)?,
                  failure: Controller.MethodFailure?) {
    }
    
    func signOut() {
        guard self.currentUser != nil else { return }
        
        self.currentUser = nil
        clearKeychain()
        
        // TODO - Notify other controllers
    }
}

// MARK: - Authentication requests
private extension AuthenticationApiController {
    
    private func performLogIn(with email: String,
                              password: String,
                              success: ((User) -> Void)?,
                              failure: Controller.MethodFailure?,
                              force: Bool) {
        
        // ignore log in if already logged in
        if force == false && currentUser != nil && currentUserAuthData != nil {
            guard !(currentUser?.customer?.emails.contains(where: { $0 == email }) ?? false) else {
                success?(currentUser!)
                return
            }
        }
        
        let parameters = ["email" : email,
                          "password" : password]
        
        let request = requestBuilder.build(for: .logIn,
                                           method: .post,
                                           parameters: parameters,
                                           encoding: URLEncoding.httpBody,
                                           authentication: .apiToken)
        self.loginRequest = request
        
        requestExecutor.execute(request: request, success: { (request, response, data) in
            guard let data = data else {
                failure?(TeamupError.Comms.unknown, nil)
                return
            }
            do {
                let user = try self.decoder.decode(User.self, from: data)
                let authData = UserAuthData(password: password)
                
                self.updateKeychain(for: user, authData: authData)
                self.currentUser = user
                
                success?(user)
                self.loginRequest = nil
            } catch {
                failure?(error, nil)
                self.loginRequest = nil
            }
        }) { (request, response, error) in
            failure?(error, response?.errorDetail)
            self.loginRequest = nil
        }
    }
}

// MARK: - Auth Management
private extension AuthenticationApiController {
    
    /// Update the keychain for a new user
    ///
    /// - Parameter user: The new user.
    /// - Parameter authData: The new user's auth data.
    private func updateKeychain(for user: User?,
                                authData: UserAuthData?) {
        guard let user = user, let authData = authData else {
            clearKeychain()
            return
        }
        
        let encoder = JSONEncoder()
        do {
            let userData = try encoder.encode(user)
            let authData = try encoder.encode(authData)
            keychain.set(userData, forKey: KeychainKeys.user)
            keychain.set(authData, forKey: KeychainKeys.userAuthData)
        } catch {}
    }
    
    private func clearKeychain() {
        keychain.delete(KeychainKeys.user)
        keychain.delete(KeychainKeys.userAuthData)
    }
    
    /// Attempt to load an authenticated user from the keychain
    ///
    /// - Returns: The currently authenticated user.
    private func loadAuthenticatedUserIfAvailable() -> User? {
        guard let data = keychain.getData(KeychainKeys.user) else { return nil }
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            return nil
        }
    }
    
    /// Attempt to load an authenticated user's auth data from the keychain.
    ///
    /// - Returns: The currently authenticated user's auth data.
    private func loadUserAuthenticationDataIfAvailable() -> UserAuthData? {
        guard let data = keychain.getData(KeychainKeys.userAuthData) else { return nil }
        do {
            return try decoder.decode(UserAuthData.self, from: data)
        } catch {
            return nil
        }
    }
}

extension AuthenticationApiController: RequestBuilderAuthProvider {
    
    func requestBuilder(requestUserTokenAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        guard let currentUser = self.currentUser else { return nil }
        return ["Authorization"  : "Token \(currentUser.token)"]
    }
    
    func requestBuilder(requestApiTokenAuthHeaders requestBuilder: RequestBuilder) -> [String : String]? {
        return ["Authorization" : "Token \(apiToken)"]
    }
}

extension AuthenticationApiController: RequestExecutorAuthResponder {
    
    func requestExecutor(_ executor: RequestExecutor,
                         encounteredUnauthorizedErrorWhenExecuting request: Request,
                         response: Response,
                         success: @escaping (Request, Response, Data?) -> Void,
                         failure: @escaping (Request, Response?, Error) -> Void) {
        guard let currentUser = currentUser,
            let authData = currentUserAuthData,
            let email = currentUser.customer?.emails.first else {
            signOut()
            return
        }
        guard request != self.loginRequest else { return }
        
        print("Attempting to reauth")
        
        // attempt to reauthenticate current user and then execute request
        performLogIn(with: email,
                     password: authData.password,
                     success:
            { (user) in
                executor.execute(request: request, success: success, failure: failure)
        },
                     failure:
            { (error, details) in
                failure(request, nil, error)
        },
                     force: true)
    }
}
