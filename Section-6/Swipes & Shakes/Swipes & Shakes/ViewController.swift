//
//  ViewController.swift
//  Swipes & Shakes
//
//  Created by Jorge Bastos on 10/16/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    
    var sounds = ["hysteric", "haughing"]
    
    func swipeDetector() {
        // create a swipe right gesture recognizer
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeDetectorswiped:")
        
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        // add swipe gesture to the view
        
        self.view.addGestureRecognizer(swipeRight)
        
        // create a swipe up gesture recongnizer
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeDetector.swiped:")
        
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        
        // add swip up gesture recongnizer to the view
        
        self.view.addGestureRecognizer(swipeUp)
        
    }
    
    func swiped(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.Right:
            print("Swipe Right")
        case UISwipeGestureRecognizerDirection.Up:
            print("Swipe Up")
        default:
            break
        }
    }


    
    // detect if the device was shaked
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.MotionShake {
            
            let randomNumber = Int(arc4random_uniform(UInt32(sounds.count)))
            
            let fileLocation = NSBundle.mainBundle().pathForResource(sounds[randomNumber], ofType: "mp3")
            
            do {
                
                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: fileLocation!))
                player.play()
                
            } catch {
                
                print("error")
            }
            
           
            
            print("Device was shaken")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

