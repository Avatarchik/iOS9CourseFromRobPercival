//
//  PostImageViewController.swift
//  Instagram Clone
//
//  Created by Jorge Bastos on 10/24/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    let activityIndicator = UIActivityIndicatorView()

 
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var message: UITextField!
    
    

    @IBAction func chooseImage(sender: AnyObject) {
        
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }

    
    @IBAction func postImage(sender: AnyObject) {
        
        
        activityIndicator.frame = self.view.frame
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // block user interaction
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        message.delegate = self
        
        let postMessage = message.text!
        message.resignFirstResponder()
        let postUserId = PFUser.currentUser()!.objectId!
        
        
        // converting image to PFfile
        let imageData = imageToPost.image!.lowestQualityJPEGNSData
        
        if imageData.length > 10485760 {
            let imageSize = imageData.length / 1024
            print("Image size is \(imageSize) Kilobytes, too large to upload")
        } else {
            let imageSize = imageData.length / 1024
            print("Image size is \(imageSize) Kilobytes,  ok to upload")
            parseImageUpload(imageData, postMessage: postMessage, postUserId: postUserId)
            
            
        }
        
        
        
    }
    
    
    // MARK: - Parse Functions
    
    func parseImageUpload(imageData: NSData, postMessage: String, postUserId: String) {
        
        let post = PFObject(className: "Post")
        
        post["message"] = postMessage
        post["userId"] = postUserId
        
        
        let imageFile = PFFile(name: "\(postUserId)_\(postMessage).jpg", data: imageData)
        post["imageFile"] = imageFile
        
        
        post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if error != nil {
                let errorString = error?.userInfo["error"]
                print(errorString)
                self.displayAlert("Error!", message: errorString! as! String)
            } else {
                print("Image Successfully uploaded")
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                // reset postView when complete
                self.imageToPost.image = UIImage(named: "unknown_user.png")
                self.message.text = ""
                self.displayAlert("Image Posted", message: "Your image has been posted successfully")
            }
        }
        
    }

    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIImagePickerController
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
        
    }
    
    // show popups
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    
} // EOF


extension UIImage
{
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)! }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)!}
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)! }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)!}
    var lowestQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.0)! }
}








/*
func textFieldDidBeginEditing(textField: UITextField) {
animateViewMoving(true, moveValue: 100)
}
func textFieldDidEndEditing(textField: UITextField) {
animateViewMoving(false, moveValue: 100)
}

func animateViewMoving (up:Bool, moveValue :CGFloat){
var movementDuration:NSTimeInterval = 0.3
var movement:CGFloat = ( up ? -moveValue : moveValue)
UIView.beginAnimations( "animateView", context: nil)
UIView.setAnimationBeginsFromCurrentState(true)
UIView.setAnimationDuration(movementDuration )
self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
UIView.commitAnimations()
}
*/

























