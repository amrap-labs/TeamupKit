//
//  InstructorsController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 21/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol InstructorsController: class {
    
    /// Load all instructors at the current business.
    ///
    /// - Parameters:
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func loadAll(success: ((ResultsPage<Instructor>) -> Void)?,
                 failure: Controller.MethodFailure?)
}
