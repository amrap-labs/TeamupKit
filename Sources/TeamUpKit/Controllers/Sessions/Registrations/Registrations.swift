//
//  Registrations.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public extension Session {
    
    public enum RegistrationState: String {
        case attending = "REGISTER"
        case notAttending = "LEAVE"
    }
}

public protocol Registrations: class {
    
    // MARK: Methods
    
    /// Load registration details for a session.
    ///
    /// - Parameters:
    ///   - session: The session to load details for.
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func loadDetails(forSession session: Session,
                     success: ((Session.RegistrationDetails) -> Void)?,
                     failure: Controller.MethodFailure?)
    
    /// Update the registration state for a session for the current user.
    ///
    /// - Parameters:
    ///   - session: The session to update registration for.
    ///   - to: The new registration state.
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func updateState(forSession session: Session,
                     to: Session.RegistrationState,
                     success: ((Session.RegistrationState) -> Void)?,
                     failure: Controller.MethodFailure?)
}
