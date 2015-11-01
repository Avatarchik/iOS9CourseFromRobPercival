//
//  ViewController.swift
//  Instagram Clone
//
//  Created by Jorge Bastos on 10/21/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
    var errorMessage = "Please try again later"
    var signupActive = true
    
    
    
    // MARK: - Action/Outlet
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButtonText: UIButton!
    @IBOutlet weak var logInButtonText: UIButton!
    @IBOutlet weak var resgisteredLabel: UILabel!

    
    @IBAction func signUpButton(sender: AnyObject) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            displayAlert("Error in form", message: "Please enter a username and password")
            
        } else {
        
            //activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signupActive {
                
                signUpUser(usernameTextField.text!, password: passwordTextField.text!)
                
            } else {
                
                loginUser(usernameTextField.text!, password: passwordTextField.text!)
            }
            
        
        }
    }
    
    @IBAction func logInButton(sender: AnyObject) {
        
        if signupActive {
            
            signUpButtonText.setTitle("Log In", forState: UIControlState.Normal)
            
            resgisteredLabel.text = "Not registered?"
            
            logInButtonText.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signupActive = false
            
        } else {
            
            signUpButtonText.setTitle("Sign Up", forState: UIControlState.Normal)
            
            resgisteredLabel.text = "Already registered?"
            
            logInButtonText.setTitle("Log In", forState: UIControlState.Normal)
            
            signupActive = true
        }
        
        
        
        
    }
    
    
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil {
            
            performSegueWithIdentifier("login", sender: self)
            
        }
    }
    
    // MARK: - Parse methots

    func signUpUser(username: String, password: String) {
        
        let user = PFUser()
        user.username = username
        user.password = password
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            self.clearTextField()
            
            if let error = error {
                
                
                
                if let errorString = error.userInfo["error"] as? String {
                    
                    self.errorMessage = errorString
                    print(errorString)
                    
                }
                
                self.displayAlert("Failed SignUp", message: self.errorMessage)
                
            
            } else {
                
                print("signup successful")
                self.performSegueWithIdentifier("login", sender: self)
                
            }
        }
    }

    func loginUser(username: String, password: String) {
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            self.clearTextField()
            
            if user != nil {
                
                print("Logged In!")
                self.performSegueWithIdentifier("login", sender: self)
                
            } else {
                
                if let errorString = error?.userInfo["erro"] as? String {
                    
                    self.errorMessage = errorString
                }
                
                self.displayAlert("Failed Login", message: self.errorMessage)
                
            }
        }
    }
    
    // MARK: - Helper functions
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func clearTextField() {
        
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    
} // eof



















