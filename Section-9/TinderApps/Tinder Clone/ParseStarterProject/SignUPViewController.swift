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
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let parameters = ["fields": "id, name, gender"]
        
        let graphRequest =  FBSDKGraphRequest(graphPath: "me", parameters: parameters)
        
        graphRequest.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            if error != nil {
                print(error)
            } else if let result = result {
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                
                PFUser.currentUser()?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if error != nil {
                        let errorString = error?.userInfo["error"]
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
