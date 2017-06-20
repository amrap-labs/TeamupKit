//
//  Memberships.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol Memberships: class {
    
    /// Load all memberships associated with the current user.
    ///
    /// - Parameters:
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func loadAll(success: ((ResultsPage<Membership>) -> Void)?,
                 failure: Controller.MethodFailure?)
    
    /// Load a membership with an identifier.
    ///
    /// - Parameters:
    ///   - id: The membership identifier.
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func loadMembership(withId id: Int,
                        success: ((Membership) -> Void)?,
                        failure: Controller.MethodFailure?)
}
