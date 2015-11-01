//
//  ViewController.swift
//  Permanent Storage
//
//  Created by Jorge Bastos on 10/12/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //NSUserDefaults.standardUserDefaults().setObject("Jorge", forKey: "name")
        
        let userName = NSUserDefaults.standardUserDefaults().objectForKey("name")
        
        print(userName)
        
        let arr = [1, 2, 3, 4]
        
        NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
        
        let returnArray = NSUserDefaults.standardUserDefaults().objectForKey("array")! as! NSArray
        
        print(returnArray)
        
        for x in returnArray {
            print(x)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

