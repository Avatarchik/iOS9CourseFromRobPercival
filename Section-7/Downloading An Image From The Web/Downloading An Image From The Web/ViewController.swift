//
//  ViewController.swift
//  Downloading An Image From The Web
//
//  Created by Jorge Bastos on 10/19/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //usingNSURLSession()

        //usignNSURLConnection()
        
        loadDownloadedImage()
        
    }
    
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveDownloadedImage(data: NSData) {
        
        let paths : [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            
            let documentsDirectory = paths.first as? String
            
            let savePath = documentsDirectory! + "/bach.jpg"
            
            NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
            
            self.imageView.image = UIImage(named: savePath)
            
        }
        
        
    }
    
    func loadDownloadedImage() {
        
        let paths : [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            
            let documentsDirectory = paths.first as? String
            
            let savePath = documentsDirectory! + "/bach.jpg"
            
            self.imageView.image = UIImage(named: savePath)
            
        }

        
    }
    
    func usignNSURLConnection() {
        
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let bach = UIImage(data: data!) {
                    
                    //self.imageView.image = bach
                    
                    var documentsDirectory : String?
                    let paths : [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    
                    if paths.count > 0 {
                        
                        documentsDirectory = paths.first as? String
                        
                        let savePath = documentsDirectory! + "/bach.jpg"
                        
                        NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                        
                        self.imageView.image = UIImage(named: savePath)
                    }

                }
            }
        }
    }
    
    
    func usingNSURLSession() {
        
        if let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg") {
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
                if error != nil {
                    print("error: \(error!.localizedDescription): \(error!.userInfo)")
                }
                else if data != nil {
                    if let bach = UIImage(data: data!) {
                        print("Received data:\n\(bach)")
                        
                        dispatch_async(dispatch_get_main_queue()) {
                          
                            self.imageView.image = bach
                            
                        }
                        
                        
                    } else {
                        print("unable to convert data to text")
                    }
                }
            }
            
            task.resume()
        }
        else {
            print("Unable to create NSURL")
        }
    }
    

} // EOF

