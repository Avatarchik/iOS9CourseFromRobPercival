//
//  ViewController.swift
//  Working With Audio
//
//  Created by Jorge Bastos on 10/16/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player : AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var slider: UISlider!
  
    @IBAction func play(sender: AnyObject) {
        
        player.play()
    }
    
    @IBAction func pause(sender: AnyObject) {
        
        player.pause()
        
        view.setNeedsDisplay()
    }
    
    @IBAction func stop(sender: AnyObject) {
        
        player.stop()
    }

    @IBAction func adustVolume(sender: AnyObject) {
        
        player.volume = slider.value
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let audioPath = NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!
        
        do {
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            
        } catch {
            //
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

