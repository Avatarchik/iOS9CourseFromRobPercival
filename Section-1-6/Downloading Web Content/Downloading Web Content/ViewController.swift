//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Jorge Bastos on 10/13/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://www.stackoverflow.com")!
        
        
        
        webView.loadRequest(NSURLRequest(URL: url))
        
        
        
        
        /*
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            // will happen when task completes
            if let urlContente = data {
                let webContent = NSString(data: urlContente, encoding: NSUTF8StringEncoding)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.webView.loadHTMLString(String(webContent!), baseURL: nil)
                })
                
                
            } else {
                // show error message
            }
        }
        
        task.resume()
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

