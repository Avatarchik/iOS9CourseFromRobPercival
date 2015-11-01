//
//  SignUPViewController.swift
//  Tinder Clone
//
//  Created by Jorge Bastos on 10/29/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SignUPViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var interestedInaWomen: UISwitch!
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInaWomen"] = interestedInaWomen.on
        PFUser.currentUser()?.saveInBackground()
        
        self.performSegueWithIdentifier("logUserIn", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let parameters = ["fields": "id, name, gender, email"]
        
        let graphRequest =  FBSDKGraphRequest(graphPath: "me", parameters: parameters)
        
        graphRequest.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            if error != nil {
                print(error)
            } else if let result = result {
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                PFUser.currentUser()?["email"] = result["email"]
                
                PFUser.currentUser()?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if error != nil {
                        let errorString = error?.userInfo["error"] as! String
                        print(errorString)
                    } else {
                        print("Did saving was successful?", success)
                    }
                })
                
                let userId = result["id"] as! String
                let facebookProfilePictureUrl = "https://graph.facebook.com/" + userId + "/picture?types=large"
                
                if let fbpicURL = NSURL(string: facebookProfilePictureUrl) {
                    if let data = NSData(contentsOfURL: fbpicURL) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imageFile: PFFile = PFFile(data: data)
                        
                        PFUser.currentUser()?["image"] = imageFile
                        PFUser.currentUser()?.saveInBackground()
                    }
                }
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func makeProfilesToParse() {
        
        let urlArray = ["http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=1760886",
            "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSziCbhHhCvWKAMauMdAY6Pe_gVfWe21snz4IhnluTaiPvjDSQmKw",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST52lN2Tgf4ZPszmy8QxCxIiPJHcxqTBo4vDZlemx2zFlqi6xD",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSBY7zE64qHj3n_LYCwyyOW6WtDK-Bf6Fmjzih1T8K7F8OD5v6",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQlNsBuv_uq3R5pf7BytvwbCFcDjlFSRrVor-lnCUNje748UHa",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQStIXaH34N43ggbPH9M7QdU1yN9vqa1hTT8mxeYF6pczFvckwu5g",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP9_Z5V1j6QbAjZzW90MpjK1ejreWV7ZF6HnZ-D_KVUe-xjFEL1w"]
        
        var counter = 1
        
        for url in urlArray {
            let nsurl = NSURL(string: url)!
            
            if let data = NSData(contentsOfURL: nsurl) {
                
                let imageFile: PFFile = PFFile(data: data)
                
                
                
                let newUser = PFUser()
                let username = "user\(counter)-ForTesting"
                
                newUser.username = username
                newUser.password = "pass"
                newUser["image"] = imageFile
                newUser["interestedInaWomen"] = false
                newUser["gender"] = "female"
                
                counter++
                newUser.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    
                    if error != nil {
                        let errorString = error?.userInfo["error"]
                        print(errorString)
                    } else if success {
                        print("did user was created and saved?", success)
                    }
                })
       
            }
            print(nsurl)
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
