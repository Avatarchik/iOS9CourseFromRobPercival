//
//  ViewController.swift
//  Webviews
//
//  Created by Jorge Bastos on 10/19/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        let html = "<html><body><h1>My Page</h1><p>This is me web page</p></body></html>"
        
        webview.loadHTMLString(html, baseURL: nil)
        
        
//        if let url = NSURL(string: "https://www.ecowebhosting.co.uk") {
//            
//            let request = NSURLRequest(URL: url)
//            
//            webview.loadRequest(request)
//            
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

