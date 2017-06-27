//
//  TeamupKitConfigTests.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import TeamupKit

class TeamupKitConfigTests: TeamupKitTests {
    
    // MARK: Config
    
    /// Test that the Config.plist is parsed correctly.
    func testConfigPlistParsing() {
        let config = Config(businessId: 0, apiVersion: .current)
        XCTAssertNotNil(config.api.url)
    }
    
    // MARK: API Config
    
    /// Test that the API Config Url responds correctly to a specified version.
    func testConfigApiVersioning() {
        let apiVersion: ApiConfig.Version = .v1
        let config = Config(businessId: 0, apiVersion: apiVersion)
        let rawVersionString = apiVersion.rawValue
        
        XCTAssertTrue(config.api.url.absoluteString.contains(rawVersionString))
    }
    
    /// Test that the API Config Url contains the current specified version when set.
    func testConfigApiCurrentVersioning() {
        let currentApiVersion = ApiConfig.Version.current
        let config = Config(businessId: 0, apiVersion: currentApiVersion)
        
        XCTAssertTrue(config.api.url.absoluteString.contains(currentApiVersion.rawValue))
    }
}
