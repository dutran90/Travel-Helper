//
//  CurrentLocation.swift
//  TravelHelper
//
//  Created by Yosemite on 3/21/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class CurrentLocation: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var currentLatitude: CLLocationDegrees!
    var currentLongitude: CLLocationDegrees!
    var location: CLLocation!
    var placeMark: CLPlacemark!
    
    func get(){
        //**** set current location
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        location = self.locationManager.location
        currentLatitude = location.coordinate.latitude
        currentLongitude = location.coordinate.longitude
        
//        self.locationManager.stopUpdatingLocation()
//        
//        self.getAndDisplayLocationStringForLocation(location)
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                println("Error:" + error.localizedDescription)
                return
            }

            if placemarks.count > 0 {
                
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
                
            }else {
                
                println("Error with data")
                
            }
        })
    }
    
    func getAndDisplayLocationStringForLocation(currentLocation: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks: [AnyObject]!, error: NSError!) in
            if error == nil && placemarks.count > 0 {
                let location = placemarks[0] as CLPlacemark
                println(location.country)
                
            }
        })
    }
    //displayLocationInfo
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        
        println(placemark.locality)
        
        println(placemark.postalCode)
        
        println(placemark.administrativeArea)
        
        println(placemark.country)
        
    }
    
    
    //didFailWithError

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error: " + error.localizedDescription)
        
    }
    
}