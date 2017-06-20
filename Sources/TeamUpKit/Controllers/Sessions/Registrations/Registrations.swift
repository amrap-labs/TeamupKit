//
//  Registrations.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

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
}
