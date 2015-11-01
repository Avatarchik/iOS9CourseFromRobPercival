//
//  ViewController.swift
//  JSON Exemple
//
//  Created by Jorge Bastos on 10/19/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = NSURL(string: "https://www.telize.com/geoip") {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data {
                    
                    print(urlContent, "\n")
                    
                    do {
                        
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                        print(jsonResult["city"])
                        
                    } catch {
                        print("JSON serialization failed")
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

