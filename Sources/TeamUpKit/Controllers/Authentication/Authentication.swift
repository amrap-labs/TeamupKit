//
//  Authentication.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public enum AuthenticationError: Error {
    
    case alreadySignedIn
}

public protocol Authentication {
    
    /// The currently authenticated user.
    var currentUser: User? { get }
    
    /// Log In to an existing Teamup account.
    ///
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    ///   - success: Execution block if the login succeeds.
    ///   - failure: Execution block if the login fails.
    func logIn(with email: String,
               password: String,
               success: ((User) -> Void)?,
               failure: Controller.MethodFailure?)
    
    /// Register a new Teamup account.
    ///
    /// - Parameters:
    ///   - email: The user's desired email address.
    ///   - password: The user's desired password
    ///   - success: Execution block if the registration succeeds.
    ///   - failure: Execution block if the registration fails.
    func register(with email: String,
                  password: String,
                  success: ((User) -> Void)?,
                  failure: Controller.MethodFailure?)
}
