//
//  Controller.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 13/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class Controller {
    
    let config: Config
    let requestBuilder: RequestBuilder
    
    // MARK: Init
    
    init(with config: Config, requestBuilder: RequestBuilder) {
        self.config = config
        self.requestBuilder = requestBuilder
    }
}
