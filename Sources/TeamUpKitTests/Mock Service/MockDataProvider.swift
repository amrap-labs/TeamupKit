//
//  MockDataProvider.swift
//  TeamupKitTests
//
//  Created by Merrick Sapsford on 28/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class MockDataProvider {
    
    private var dataDictionary: [String : Any]?
    
    // MARK: Init
    
    init() {
        
        let bundle = Bundle(for: type(of: self))
        let file = bundle.url(forResource: "mockdata", withExtension: "json")!
        do {
            let data = try  Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let dictionary = json as! [String : Any]
            self.dataDictionary = dictionary
        } catch {}
    }
    
    func provide(dataFor url: String) -> Data? {
        guard let dataDictionary = self.dataDictionary else { return nil }
        guard let object = dataDictionary[url] else { return nil }
        
        do {
            return try JSONSerialization.data(withJSONObject: object, options: [])
        } catch {
            return nil
        }
    }
}
