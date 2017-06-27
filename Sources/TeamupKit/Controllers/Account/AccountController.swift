//
//  AccountController.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol AccountController: class {
    
    // MARK: Properties
    
    var memberships: MembershipsController { get }
}
