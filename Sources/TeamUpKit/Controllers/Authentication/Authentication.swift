//
//  Authentication.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol Authentication {
    
    /// Log In to an existing Teamup account.
    ///
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    ///   - success: Execution block if the request succeeds.
    ///   - failure: Execution block if the request fails.
    func logIn(with email: String,
               password: String,
               success: ((User) -> Void)?,
               failure: Controller.MethodFailure?)
}
