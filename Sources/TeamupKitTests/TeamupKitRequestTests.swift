//
//  TeamupKitRequestTests.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 26/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import XCTest
@testable import TeamupKit

class TeamupKitRequestTests: TeamupKitTests {

    // MARK: UrlBuilder
    
    /// Test UrlBuilder generates a URL successfully for an endpoint.
    func testUrlBuilderGeneration() {
        let urlBuilder = teamup.requestBuilder.urlBuilder
        let url = urlBuilder.build(for: .logIn)
        
        let path = Endpoint.logIn.path
        let baseUrl = teamup.config.api.url.absoluteString
        
        XCTAssertTrue(url.absoluteString.contains(path) && url.absoluteString.contains(baseUrl))
    }
    
    // MARK: RequestBuilder
    
    /// Test request builder will successfully generate a valid request.
    func testRequestEndpointGeneration() {
        
        let headers = ["test" : "header"]
        let parameters = ["test" : "parameter"]
        
        let request = teamup.requestBuilder.build(for: .sessions,
                                                  method: .get,
                                                  headers: headers,
                                                  parameters: parameters,
                                                  authentication: .none)
        
        XCTAssertEqual(headers, request.headers!)
        XCTAssertEqual(parameters.count, request.parameters?.count)
    }
    
    /// Test request builder will inject API token authentication headers correctly.
    func testRequestEndpointGenerationApiTokenAuthentication() {
        
        let request = teamup.requestBuilder.build(for: .sessions,
                                                  method: .get,
                                                  authentication: .apiToken)
        XCTAssertNotEqual(0, request.headers?.count)
    }
    
    /// Test request builder will inject user token authentication headers correctly.
    func testRequestEndpointGenerationUserTokenAuthentication() {
        
        let request = teamup.requestBuilder.build(for: .sessions,
                                                  method: .get,
                                                  authentication: .userToken)
        XCTAssertNotEqual(0, request.headers?.count)
    }
}
