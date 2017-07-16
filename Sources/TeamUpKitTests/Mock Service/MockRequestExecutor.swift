//
//  MockRequestExecutor.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 27/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
@testable import TeamupKit

class MockRequestExecutor: RequestExecutor {
    
    // MARK: Properties
    
    var authResponder: RequestExecutorAuthResponder?
    let dataProvider = MockDataProvider()
    
    // MARK: Init
    
    required init() {
        
    }
    
    // MARK: Execution
    
    func execute(request: Request,
                 success: @escaping RequestExecutor.ExecutionSuccess,
                 failure: @escaping RequestExecutor.ExecutionFailure) {
        if let data = dataProvider.provide(dataFor: request.url.absoluteString) {
            let urlResponse = HTTPURLResponse(url: request.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            let response = Response(with: urlResponse, and: data, for: request, error: nil)!
            success(request, response, data)
        } else {
            failure(request, nil, RequestError.unknown)
        }
    }
}
