//
//  WaitlistsController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol WaitlistsController: class {
    
    /// Load the waitlist for a session.
    ///
    /// - Parameters:
    ///   - session: The session to load the waitlist for.
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func load(forSession session: Session,
              success: ((Session.Waitlist) -> Void)?,
              failure: Controller.MethodFailure?)
}
