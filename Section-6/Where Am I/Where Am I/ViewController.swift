//
//  ViewController.swift
//  Where Am I
//
//  Created by Jorge Bastos on 10/14/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var locatManager : CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locatManager = CLLocationManager()
        locatManager.delegate = self
        locatManager.desiredAccuracy = kCLLocationAccuracyBest
        locatManager.requestWhenInUseAuthorization()
        locatManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation : CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        self.courseLabel.text = "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        self.altitudeLabel.text =  "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            var placemark : CLPlacemark!
            if error == nil && placemarks!.count > 0 {
                placemark = placemarks![0]
                print(placemark)
            }
            
            if error != nil {
                print(error)
            } else {
                if let p = placemarks?.first! {
                    print(p)
                    
                    var subThoroughfare = ""
                    
                    if p.subThoroughfare != nil {
                       subThoroughfare = p.subThoroughfare!
                    }
                    
                    self.addressLabel.text = "\(p.name!) \(subThoroughfare) \n\(p.thoroughfare!) \(p.subLocality!) \n\(p.subAdministrativeArea!) \(p.postalCode!) \(p.country!)"
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

