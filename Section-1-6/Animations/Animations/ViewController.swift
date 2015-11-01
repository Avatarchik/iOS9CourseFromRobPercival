//
//  ViewController.swift
//  Animations
//
//  Created by Jorge Bastos on 10/13/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let aliens = ["alien1.png", "alien2.png", "alien3.png", "alien4.png", "alien5.png"]
    
    var counter = 0
    
    var timer = NSTimer()
    
    var isAnimating = true
    
    @IBOutlet weak var alienImage: UIImageView!
    
    @IBAction func updateImageButton(sender: AnyObject) {
        
        if isAnimating == true {
            
            timer.invalidate()
            isAnimating = false
            (sender as! UIButton).setTitle("Stop", forState: UIControlState.Normal)
            
            
        } else {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
            isAnimating = true
            (sender as! UIButton).setTitle("Start", forState: UIControlState.Normal)
            
        }
        
        
    }
    
    func doAnimation() {
        if counter == 4 {
            counter = 0
        } else {
            counter++
        }
        alienImage.image = UIImage(named: aliens[counter])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*
    override func viewDidLayoutSubviews() {
        
        //alienImage.center = CGPointMake(alienImage.center.x - 400, alienImage.center.y)
        //alienImage.alpha = 0
        alienImage.frame =  CGRectMake(100, 20, 0, 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(3) { () -> Void in
            
            //self.alienImage.center = CGPointMake(self.alienImage.center.x + 400, self.alienImage.center.y)
            //self.alienImage.alpha = 1
            self.alienImage.frame = CGRectMake(100, 20, 100, 200)
        }
    }
    */
    
}

