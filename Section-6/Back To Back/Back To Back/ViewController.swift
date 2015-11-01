//
//  ViewController.swift
//  Back To Back
//
//  Created by Jorge Bastos on 10/16/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var timer = NSTimer()
    var duration : Float = 0.0
    var currentTime : Float = 0.0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scrubSlider: UISlider!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    
    @IBAction func play(sender: AnyObject) {
        
        player.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("audioCurrentTime"), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        player.pause()
        timer.invalidate()
    }
    
    @IBAction func stop(sender: AnyObject) {
        
        timer.invalidate()
        player.pause()
        audioPlayer()
    }
    
    @IBAction func rewind(sender: AnyObject) {
    }
    
    @IBAction func forward(sender: AnyObject) {
    }
    
    @IBAction func adjustVolume(sender: AnyObject) {
        
        player.volume = slider.value
    }

    @IBAction func scrub(sender: AnyObject) {
        player.currentTime = NSTimeInterval(scrubSlider.value * Float(player.duration))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        audioPlayer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioPlayer() {
        do {
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!))
            
            duration = Float(player.duration / player.duration)
            scrubSlider.maximumValue = duration
            scrubSlider.minimumValue = 0.0
            progress.progress = scrubSlider.minimumValue
            
        } catch {
            // didn't work
        }
    }
    
    func audioCurrentTime() {
        scrubSlider.value = Float((1 - ((player.duration - player.currentTime) / player.duration)))
        progress.setProgress(scrubSlider.value, animated: true)
        
        var startLabel = "\(player.currentTime)"
        
        let startTimeRange = startLabel.startIndex.advancedBy(5)..<startLabel.endIndex
        
        startLabel.removeRange(startTimeRange)
        
        startTimeLabel.text = startLabel.stringByReplacingOccurrencesOfString(".", withString: ":")
        
        
        var endLabel = "\(-player.duration + player.currentTime)"
        
        let endTimeRange = endLabel.startIndex.advancedBy(6)..<endLabel.endIndex
        
        endLabel.removeRange(endTimeRange)
        
        endTimeLabel.text = endLabel.stringByReplacingOccurrencesOfString(".", withString: ":")

        
        let progression = Float((1 - ((player.duration - player.currentTime) / player.duration)))
        print("Duration", duration, "\n", "currentTime", player.currentTime, "\n", "Slider", scrubSlider.value, "\n", "Progress", progression, "\n")
        
        
        
        if scrubSlider.value == duration {
            timer.invalidate()
        }
    }


}

