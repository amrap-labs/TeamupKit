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
                            businessId: dictionary["businessId"] as! Int)
        
        if !teamup.auth.isAuthenticated {
            teamup.auth.logIn(email: dictionary["email"] as! String,
                              password: dictionary["password"] as! String,
                              success: { (user) in
                                print("logged in!")
            },
                              failure: nil)
    
        }
    
        teamup.auth.logIn(email: "test@test.com",
                          password: "password",
                          success: { (user) in
                            
        }) { (error, details) in
            
        }
        
        let startDateString = "2017-06-05"
        let endDateString = "2017-06-27"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        teamup.sessions.load(between: dateFormatter.date(from: startDateString)!,
                             and: dateFormatter.date(from: endDateString)!, success: { (sessions) in
            teamup.sessions.loadPage(at: .next, for: sessions, success: { (sessions) in
            }, failure: nil)
        }, failure: nil)
        
//        teamup.sessions.load(sessionWithId: 2313131321, includeRegistrationDetails: true, success: { (session) in
//
//        }) { (error) in
//            print(error)
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

