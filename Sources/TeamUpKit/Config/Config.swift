//
//  Config.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal class Config {
    
    // MARK: Constants
    
    private struct Constants {
        static let plistFilename = "Config"
    }
    
    // MARK: Properties
    
    let business: BusinessConfig
    private(set) var api: ApiConfig!
    
    private var configDictionary: [String : Any] {
        let frameworkBundle = Bundle(for: type(of: self))
        let filename = Constants.plistFilename
        
        var bundle: Bundle = frameworkBundle
        if frameworkBundle.path(forResource: filename, ofType: "plist") == nil { // fall back to resource bundle
            let resourceBundleUrl = frameworkBundle.resourceURL!.appendingPathComponent("TeamupKit.bundle")
            bundle = Bundle(url: resourceBundleUrl)!
        }
        
        let plist = bundle.path(forResource: "Config", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: plist)!
        return dictionary as! [String : Any]
    }
    
    init(businessId: Int,
         apiVersion: ApiConfig.Version) {
        self.business = BusinessConfig(businessId: businessId)
        self.api = ApiConfig(with: configDictionary,
                             version: apiVersion)
    }
}
