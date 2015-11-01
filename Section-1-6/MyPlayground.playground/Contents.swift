//: Playground - noun: a place where people can play

import UIKit



//Duration 48.849 Slider 26.9803
//Progress 1.0

var duration = String(48.84945678946).stringByReplacingOccurrencesOfString(".", withString: ":")
var playerCurrentTime = 24.425
var progress = 0.0
var slider = 0.0
var index = 0.0

var durationFormat = duration.startIndex.advancedBy(5)..<duration.endIndex

duration.removeRange(durationFormat)

var welcome = "hello"

welcome.insert("!", atIndex: welcome.endIndex)

welcome.insertContentsOf(" Jorge".characters, at: welcome.endIndex)

var range = welcome.startIndex.advancedBy(1)..<welcome.endIndex

welcome.removeRange(range)

print(welcome)

var time = NSDate()




