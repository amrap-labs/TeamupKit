//
//  RequestExecutor.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal enum RequestExecutorError: Error {
    case cancelled
    case unknown
}

internal protocol RequestExecutorAuthResponder: class {
    
    /// The request executor experienced an authentication error when executing a request.
    ///
    /// - Parameters:
    ///   - executor: The request executor.
    ///   - request: The request that failed.
    ///   - response: The response that was received.
    ///   - success: The closure to execute on a successful request.
    ///   - failure: The closure to execute on a failed request.
    func requestExecutor(_ executor: RequestExecutor,
                         encounteredUnauthorizedErrorWhenExecuting request: Request,
                         response: Response,
                         success: @escaping RequestExecutor.ExecutionSuccess,
                         failure: @escaping RequestExecutor.ExecutionFailure)
}

internal protocol RequestExecutor: class {
    
    // MARK: Types
    
    typealias ExecutionSuccess = (_ request: Request, _ response: Response, _ data: Data?) -> Void
    typealias ExecutionFailure = (_ request: Request, _ response: Response?, _ error: Error) -> Void
    
    // MARK: Properties
    
    weak var authResponder: RequestExecutorAuthResponder? { get set }
    
    // MARK: Init
    
    init()
    
    // MARK: Execution
    
    /// Execute a request.
    ///
    /// - Parameters:
    ///   - request: The request to execute.
    ///   - success: Closure to execute on a successfuly execution.
    ///   - failure: Closure to execute on a failed execution.
    func execute(request: Request,
                 success: @escaping ExecutionSuccess,
                 failure: @escaping ExecutionFailure)
}
