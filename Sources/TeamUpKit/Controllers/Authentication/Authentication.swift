//
//  Authentication.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public protocol Authentication {
    
    func logIn(with email: String, password: String)
}
