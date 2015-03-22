//
//  ViewController.swift
//  TravelHelper
//
//  Created by Yosemite on 3/21/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var openBtn: UIBarButtonItem!
    
    let searchRadius: CLLocationDistance = 1000
    
    let locationManager = CLLocationManager()
    var location: CLLocation!
    var placeMarks: CLPlacemark!
    
    var currentLatitude: CLLocationDegrees!
    var currentLongitude: CLLocationDegrees!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initial location in Honolulu
        //let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        
        
        //**** SET CURRENT LOCATION
        
//        let currentLocation = CurrentLocation()
//        currentLocation.get()
//        currentLatitude = currentLocation.currentLatitude
//        currentLongitude = currentLocation.currentLongitude
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        location = self.locationManager.location

        if location == nil{
            currentLatitude = 37.7873589
            currentLongitude = -122.408227
            let artwork = Artwork(title: "San Francissco",
                locationName: "",
                discipline: "Sculpture",
                coordinate: CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude))
            
            mapView.addAnnotation(artwork)

        }else{
            currentLatitude = location.coordinate.latitude
            currentLongitude = location.coordinate.longitude
        }
        
        let initialLocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        centerMapOnLocation(initialLocation)
        //****
        
        mapView.delegate = self
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            searchRadius * 2.0, searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                println("Error:" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                
                let pm = placemarks[0] as CLPlacemark
                self.placeMarks = pm
                self.displayLocationInfo(pm)
            
            }else {
                
                println("Error with data")
                
            }
        })
    }
    
    //displayLocationInfo
    var exist = false
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        
        println(placemark.locality)
        
        println(placemark.postalCode)
        
        println(placemark.administrativeArea)
        
        println(placemark.country)
        
        //**** SHOW ARTWORK ON MAP

        var locationName: String
        if exist == false{
            locationName = "\(placeMarks.locality), \(placeMarks.postalCode), \(placeMarks.administrativeArea) , \(placeMarks.country) "
            
            let artwork = Artwork(title: "You're here",
                locationName: locationName,
                discipline: "Sculpture",
                coordinate: CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude))
            
            mapView.addAnnotation(artwork)
            //****
            exist = true
        }
        
    }
    
    
    //didFailWithError
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error: " + error.localizedDescription)
        
    }

}

