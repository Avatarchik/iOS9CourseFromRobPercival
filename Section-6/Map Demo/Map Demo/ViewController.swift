//
//  ViewController.swift
//  Map Demo
//
//  Created by Jorge Bastos on 10/14/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var myLocationManager = CLLocationManager()
    
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get user location
        myLocationManager.delegate = self
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.requestWhenInUseAuthorization()
        myLocationManager.startUpdatingLocation()
        
        
        let latitude : CLLocationDegrees = 37.332040
        let longtitude : CLLocationDegrees = -122.029609
        
        let latDelta : CLLocationDegrees = 0.01
        let lonDelta : CLLocationDegrees = 0.01
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        
        // map annotation
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Apple"
        annotation.subtitle = "I will work here"
        
        map.addAnnotation(annotation)
        
        // long press gesture recognizer
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
    }

    
    // make map annotation
    
    func action(gestureRecognizer: UIGestureRecognizer ) {
        print("gesture Recognized")
        
        let touchPoint = gestureRecognizer.locationInView(self.map)
        
        let newCoordinate : CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "New Place"
        
        map.addAnnotation(newAnnotation)
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation : CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta : CLLocationDegrees = 0.01
        let lonDelta : CLLocationDegrees = 0.01
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
latitude, longitude, course, speed, nearest address
*/
