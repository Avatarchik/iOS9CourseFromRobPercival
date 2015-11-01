//
//  ViewController.swift
//  Tinder Clone
//
//  Created by Jorge Bastos on 10/29/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    
    @IBAction func singIn(sender: AnyObject) {
        
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) { (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                
                if let user = user {
                    
                    if let interestedInWomen = user["interestedInaWomen"] {
                        self.performSegueWithIdentifier("logUserIn", sender: self)
                    print(user)
                    } else {
                        self.performSegueWithIdentifier("showSigninScreen", sender: self)
                    }
                }
            }
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
        if let username = PFUser.currentUser()?.username {
            
            if let interestedInWomen = PFUser.currentUser()?["interestedInaWomen"] {
                self.performSegueWithIdentifier("logUserIn", sender: self)
            } else {
                self.performSegueWithIdentifier("showSigninScreen", sender: self)
            }
            
        }
        
    }
    
    
    
} // end of class

