//
//  ViewController.swift
//  TinderClone
//
//  Created by Jorge Bastos on 10/27/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4


class ViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    
    var kbHeight: CGFloat!
    
    @IBOutlet weak var chanelTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func signIn(sender: AnyObject) {
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile"]
        fbLoginButton.center = self.view.center
        view.addSubview(fbLoginButton)
    }
    
    @IBAction func subscribeTapped(sender: AnyObject) {
        
        if chanelTextField.text != "" {
        parseSubscribePushNotification(chanelTextField.text!)
        }
    }
    
    @IBAction func sendPushTapped(sender: AnyObject) {
        
        if messageTextField.text != "" && chanelTextField.text != "" {
            parseSendPushNotificaton(chanelTextField.text!, message: messageTextField.text!)
        }
    }
    
    @IBAction func parseUserTapped(sender: AnyObject) {
        let parseUserId = PFUser.currentUser()
        print(parseUserId)
    }
    
    @IBAction func facebookUserTapped(sender: AnyObject) {
        
        if let facebookUserId = FBSDKAccessToken.currentAccessToken() {
            print(facebookUserId)
        } else {
            print("not logged to facebook")
        }
    }
    

    @IBAction func loginParseTapped(sender: AnyObject) {
        
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("You need to login to facebook first")
        } else {
            
            PFFacebookUtils.linkUserInBackground(PFUser.currentUser()!, withAccessToken: FBSDKAccessToken.currentAccessToken(), block: { (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    let parseUserId = PFUser.currentUser()
                    let facebookUserId = FBSDKAccessToken.currentAccessToken()
                    print("successfully linked",parseUserId, facebookUserId)
                } else {
                    let errorString = error?.userInfo["error"]
                    print(errorString)
                }
            })
            
        }
    }
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error == nil) {
            print(result)
            let accessToken = FBSDKAccessToken.currentAccessToken()
            print(accessToken)
        } else {
            let errorString = error.userInfo["error"]
            print(errorString)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user logged out")
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        chanelTextField.delegate = self
        messageTextField.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        PFUser.logOut()
        
        if let username = PFUser.currentUser()?.username {
            performSegueWithIdentifier("ShowSigninScrren", sender: self)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                self.animateTextField(true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }
    

    func animateTextField(up: Bool){
        let moviment = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self.view.frame = CGRectOffset(self.view.frame, 0, moviment)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func parseSubscribePushNotification(channel: String) {
        
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.addUniqueObject(channel, forKey: "channels")
        currentInstallation.saveInBackgroundWithBlock { (succses: Bool, error: NSError?) -> Void in
            
            if error != nil {
                let errorString = error?.userInfo["error"]
                print(errorString)
            } else {
                print("successfully subscribed to the channel")
            }
        }
        
    }
    
    func parseSendPushNotificaton(channel: String, message: String) {
        // Parse push notificaton
        // Send a notification to all devices subscribed to the "Giants" channel.
        let push = PFPush()
        push.setChannel(channel)
        push.setMessage(message)
        push.sendPushInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if error != nil {
                let errorString = error?.userInfo["error"]
                print(errorString)
            } else {
                print("successfully sent the push notification")
            }
        }
    }

} // eof

