//
//  TeamupKitTests.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import TeamupKit

class TeamupKitTests: XCTestCase {
    
    private(set) var teamup: Teamup!
    
    override func setUp() {
        super.setUp()
        
        let environment = MockEnvironment()
        teamup = Teamup(apiToken: "TEST_TOKEN", businessId: 0,
                        apiVersion: .current,
                        environment: environment)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
