//
//  ViewController.swift
//  Stopwatch
//
//  Created by Jorge Bastos on 10/12/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var time = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    
    func increaseTimer() {
        time++
        timerLabel.text = String(time)
    }
    
    @IBAction func play(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseTimer"), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func reset(sender: AnyObject) {
        timer.invalidate()
        timerLabel.text = "0"
        time = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

