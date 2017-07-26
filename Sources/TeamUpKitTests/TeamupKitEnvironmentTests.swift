//
//  TeamupKitEnvironmentTests.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import TeamupKit

class TeamupKitEnvironmentTests: TeamupKitTests {
    
    /// Test that Teamup can be configured with a specified environment.
    func testEnvironmentConfiguration() {
        let teamup = Teamup(apiToken: "UNKNOWN", businessId: 0,
                            apiVersion: .current,
                            environment: MockEnvironment())
        XCTAssertTrue(teamup.requestExecutor is MockRequestExecutor)
    }
    
    /// Test that Teamup will fallback to a default API environment if none is specified.
    func testEnvironmentDefaultFallback() {
        let teamup = Teamup(apiToken: "UNKNOWN", businessId: 0,
                            apiVersion: .current, environment: nil)
        XCTAssertNotNil(teamup.auth)
    }
}
