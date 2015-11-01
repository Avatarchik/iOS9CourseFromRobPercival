//
//  ViewController.swift
//  How Many Fingers
//
//  Created by Jorge Bastos on 10/11/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!

    @IBAction func submit(sender: AnyObject) {
        
        let finger = String(randomFinger())
        print(finger)
       print(textField.text)

        if textField.text != "" {
            if finger == textField.text {
                answerLabel.text = "You're right!"
            } else {
                answerLabel.text = "Wrong!, It was a " + finger
            }
            
        } else {
            answerLabel.text = "Please enter a number"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func randomFinger() -> Int {
        return Int(arc4random_uniform(6))
    }
    
}

