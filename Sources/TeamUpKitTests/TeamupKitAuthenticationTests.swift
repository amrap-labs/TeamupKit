//
//  TeamupKitAuthenticationTests.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 28/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import TeamupKit

class TeamupKitAuthenticationTests: TeamupKitTests {
    
    /// Test the logIn method available in AuthenticationController.
    func testLogInMethod() {
        
        teamup.auth.logIn(with: "Test User",
                          password: "Test Password",
                          success: { (user) in
              XCTAssertTrue(user.expires.count > 0)
        }) { (error, details) in
            XCTFail("Log In method fails")
        }
    }
}
