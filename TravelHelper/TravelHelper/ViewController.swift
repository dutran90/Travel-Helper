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
    
    let searchRadius: CLLocationDistance = 1000
    
    let locationManager = CLLocationManager()
    
    var currentLatitude: CLLocationDegrees!
    var currentLongitude: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initial location in Honolulu
        //let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        //**** set current location
        let currentLocation = CurrentLocation()
        currentLocation.get()
        currentLatitude = currentLocation.currentLatitude
        currentLongitude = currentLocation.currentLongitude
        
        let initialLocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        centerMapOnLocation(initialLocation)
        //****
        
        //**** show artwork on map
//        let locationName = "\(currentLocation.placeMark.locality) \(currentLocation.placeMark.administrativeArea) \(currentLocation.placeMark.country)"
        let artwork = Artwork(title: "You are here",
            locationName: "(\(currentLatitude) ; \(currentLongitude))",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude))
        
        mapView.addAnnotation(artwork)
        //****
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            searchRadius * 2.0, searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

