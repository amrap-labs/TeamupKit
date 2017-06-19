//
//  Sessions.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 19/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol Sessions: class {
    
    func loadSessions(between startDate: Date,
                      and endDate: Date,
                      includeRegistrationDetails: Bool,
                      includeNonActive: Bool,
                      success: (() -> Void)?,
                      failure: Controller.MethodFailure?)
}
