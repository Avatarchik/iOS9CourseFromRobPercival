//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse


class ViewController: UIViewController {
    
    
    

    @IBAction func singIn(sender: AnyObject) {
        
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) { (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                
                if let user = user {
                    
                    self.performSegueWithIdentifier("showSigninScreen", sender: self)
                    print(user)
                }
            }
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
//        let push = PFPush()
//        let channels = [ "Giants", "Mets" ]
//        
//        push.setChannels(channels)
//        push.setMessage("The Giants won against the Mets 2-3.")
//        push.sendPushInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            
//            if let error = error {
//                print(error)
//            } else {
//                print("Push messsage was sent successful?", success)
//            }
//        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
        if let username = PFUser.currentUser()?.username {
            
            performSegueWithIdentifier("showSigninScreen", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

















