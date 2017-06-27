//
//  AuthenticationApiController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthenticationApiController: Controller, AuthenticationController {
    
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
    
    private var loginRequest: TURequest?
    
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
        
        currentUser = loadAuthenticatedUserIfAvailable()
        currentUserAuthData = loadUserAuthenticationDataIfAvailable()
    }
    
    // MARK: Authentication
    
    func logIn(with email: String,
               password: String,
               success: ((User) -> Void)?,
               failure: MethodFailure?) {
        performLogIn(with: email,
                     password: password,
                     success: success,
                     failure: failure,
                     force: false)
    }
    
    func register(with email: String,
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
                              failure: MethodFailure?,
                              force: Bool) {
        
        // ignore log in if already logged in
        if force == false && currentUser != nil && currentUserAuthData != nil {
            guard !(currentUser?.customer.emails.contains(where: { $0 == email }) ?? false) else {
                success?(currentUser!)
                return
            }
        }
        
        let body = TURequest.Body(["email" : email,
                                 "password" : password])
        
        let request = requestBuilder.build(for: .logIn,
                                           method: .post,
                                           contentType: .formUrlEncoded,
                                           body: body,
                                           authentication: .apiToken)
        self.loginRequest = request
        requestExecutor.execute(request: request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(TURequestError.unknown)
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
                    failure?(TURequestError(with: error))
                    self.loginRequest = nil
                }
        }) { (request, response, error) in
            failure?(error)
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
                         encounteredUnauthorizedErrorWhenExecuting request: TURequest,
                         response: TUResponse,
                         success: @escaping (TURequest, TUResponse, Data?) -> Void,
                         failure: @escaping (TURequest, TUResponse?, TURequestError) -> Void) {
        guard let currentUser = currentUser , let authData = currentUserAuthData else {
            // TODO - Sign out
            return
        }
        guard request != self.loginRequest else { return }
        
        print("Attempting to reauth")
        
        // attempt to reauthenticate current user and then execute request
        performLogIn(with: currentUser.customer.emails.first!,
                     password: authData.password,
                     success:
            { (user) in
                executor.execute(request: request, success: success, failure: failure)
        },
                     failure:
            { (error) in
                failure(request, nil, error)
        },
                     force: true)
    }
}
