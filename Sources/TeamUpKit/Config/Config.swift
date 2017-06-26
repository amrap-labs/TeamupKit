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
    
    /// The business configuration.
    let business: BusinessConfig
    /// The API configuration.
    private(set) var api: ApiConfig!
    
    /// Dictionary of configuration items from Config.plist
    private var configDictionary: [String : Any] {
        let frameworkBundle = Bundle(for: type(of: self))
        let filename = Constants.plistFilename
        
        var bundle: Bundle = frameworkBundle
        if frameworkBundle.path(forResource: filename, ofType: "plist") == nil { // fall back to resource bundle
            let resourceBundleUrl = frameworkBundle.resourceURL!.appendingPathComponent("TeamupKit.bundle")
            bundle = Bundle(url: resourceBundleUrl)!
        }
        
        // attempt to load config dictionary
        guard let plist = bundle.path(forResource: "Config", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: plist) else {
                fatalError("Unable to configure Teamup Config. Please raise an issue on Github: https://github.com/amrap-labs/TeamupKit")
        }
        
        return dictionary as! [String : Any]
    }
    
    // MARK: Init
    
    /// Initialize a configuration.
    ///
    /// - Parameters:
    ///   - businessId: The business Id for the configuration.
    ///   - apiVersion: The version of the API to use.
    init(businessId: Int,
         apiVersion: ApiConfig.Version) {
        self.business = BusinessConfig(businessId: businessId)
        self.api = ApiConfig(with: configDictionary,
                             version: apiVersion)
    }
}
