//
//  BusinessController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol BusinessController: class {
    
    // MARK: Properties
    
    /// Controller for business instructors.
    var instructors: InstructorsController { get }
    
    // MARK: Methods
    
    /// Load the details of the current business.
    ///
    /// - Parameters:
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func load(success: ((Business) -> Void)?,
              failure: Controller.MethodFailure?)
    
    /// Load the details of a business.
    ///
    /// - Parameters:
    ///   - id: The id of the business.
    ///   - success: Closure to execute on successful request.
    ///   - failure: Closure to execute of failed request.
    func load(withId id: Int,
              success: ((Business) -> Void)?,
              failure: Controller.MethodFailure?)
}
