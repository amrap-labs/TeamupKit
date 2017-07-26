//
//  ExecutableRequest.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

class ExecutableRequest: Request {
    
    // MARK: Properties
        
    private var _response: Response?
    override var response: Response? {
        set {
            _response = newValue
        } get {
            return _response
        }
    }
    
    private var _inProgress: Bool = false
    override var inProgress: Bool {
        set {
            _inProgress = inProgress
        } get {
            return _inProgress
        }
    }
    
    weak var dataRequest: DataRequest?
    
    // MARK: Actions
    
    override func cancel() {
        dataRequest?.cancel()
    }
}
