//
//  ViewController.swift
//  TeamupKit-Example
//
//  Created by Merrick Sapsford on 10/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TeamupKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plist = Bundle(for: type(of: self)).path(forResource: "Credentials", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: plist) as! [String : Any]
        
        let teamup = Teamup(apiToken: dictionary["apiToken"] as! String,
                            providerId: dictionary["providerId"] as! String)
        
        teamup.auth.logIn(with: "", password: "")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

