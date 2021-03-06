//
//  AddTrip.swift
//  Travel Helper
//
//  Created by binladenit on 4/2/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddTrip : UIViewController, MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var mkTrip: MKMapView!
    
    var mapManager = MapManager()
    
    var locationManager: CLLocationManager!
    
    var tfFrom : String!
    var tfTo : String!
    
    var originLat: Double!
    var originLng: Double!
    var destLat: Double!
    var destLng: Double!
    
    var btnNext : UIButton!
    
    var titView = UIView()
    
    var routeDone = false
    
    var steps: NSArray!
    
    var cityName: String!
    
    var cities: NSMutableArray = []
    
    
    override func viewDidLoad() {
        
        let screenBound = UIScreen.mainScreen().bounds
        let screenSize = screenBound.size
        
        let t = self.navigationController?.navigationBar.frame.size.height
        
        let h = screenSize.height - t!
        
        mkTrip.frame.size = CGSize(width: screenSize.width, height: h)
        mkTrip.frame.origin = CGPoint(x: 0, y: 100)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevron-double-right.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "next")
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevron-double-left.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        

        let sizeWidth = self.navigationController?.navigationBar.frame.size.width
        let sizeHeight = self.navigationController?.navigationBar.frame.size.height

        titView.frame.size = CGSize(width: sizeWidth!/2, height: sizeHeight!)
        let img = RBResizeImage(UIImage(named: "map-marker-radius.png")!, titView.frame.size)
        let imgV = UIImageView(image: img)
        imgV.image = imgV.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imgV.tintColor = self.UIColorFromRGB(10931807)
        imgV.center = CGPoint(x: sizeWidth!/4, y: sizeHeight!/2)
        titView.addSubview(imgV)
        self.navigationItem.titleView = titView
        
        let gesture = UITapGestureRecognizer(target: self, action: "openRoute")
        self.navigationItem.titleView?.addGestureRecognizer(gesture)
        
        self.animateButtonRoute()
        self.navigationItem.rightBarButtonItem?.enabled = false
        
//        self.animateButtonNext()
        
        self.mkTrip?.delegate = self
        
    }
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func back(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func next(){
        

        
//        for step in self.getArrayLatLngFromSteps(self.steps){
//            
//            self.getCityFromLatLng(step.valueForKey("lat") as Double, lng: step.valueForKey("lng") as Double)
//            
//            //                                        self.cities.addObject(self.cityName)
//            
//        }
        
        self.getCityFromLatLng(16.0544371, lng: 108.2030968)
        
        self.performSegueWithIdentifier("addTripSegue1", sender: nil)
        
    }
    
    func animateButtonRoute() {
        
        titView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.titView.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                if self.routeDone == true{
                    return
                }
                self.animateButtonRoute()
            }
        )
    }
    
    func animateButtonNext() {
        
//        let t = self.navigationItem.rightBarButtonItem?.customView
//        let t = self.navigationItem.rightBarButtonItem?.valueForKey("view") as UIView
        
        self.btnNext.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.btnNext.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                self.animateButtonNext()
            }
        )
    }
    
    func openRoute(){
        
        //create dialog to input direction information
        titView.layer.removeAllAnimations()
        
//        let alert = UIAlertView()
//        alert.title = "Route your trip"
//        
//        let view = UIView()
//        view.frame.size = CGSize(width: 100, height: 200)
//        
//        let lbFrom = UILabel(frame: CGRect(x: 10, y: 10, width: 60, height: 44))
//        lbFrom.text = "From:"
//        
//        let lbTo = UILabel(frame: CGRect(x: lbFrom.frame.origin.x, y: lbFrom.frame.origin.y + lbFrom.frame.size.height+20, width: lbFrom.frame.size.width, height: lbFrom.frame.size.height))
//        lbTo.text = "To"
//        
//        tfFrom.frame.size = CGSize(width: 100, height: lbFrom.frame.size.height)
//        tfFrom.frame.origin = CGPoint(x: lbFrom.frame.origin.x + lbFrom.frame.size.width + 20  , y: lbFrom.frame.origin.y)
//        tfTo.frame.size = CGSize(width: tfFrom.frame.size.width, height: tfFrom.frame.size.height)
//        tfTo.frame.origin = CGPoint(x: tfFrom.frame.origin.x, y: tfFrom.frame.origin.y+tfFrom.frame.size.height + 20)
//        
//        let btnOK = UIButton()
//        btnOK.frame.size = CGSize(width: 50, height: 50)
//        btnOK.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 50)
//        
//        view.addSubview(lbFrom)
//        view.addSubview(tfFrom)
//        view.addSubview(lbTo)
//        view.addSubview(tfTo)
//        view.addSubview(btnOK)
//        
//        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        view2.backgroundColor = UIColor.redColor()
//        
//        alert.addSubview(view2)
//        alert.autoresizesSubviews = true
        let alert = UIAlertView(title: "Direction", message: "Please input your trip", delegate: self, cancelButtonTitle: "OK")
        alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
        alert.textFieldAtIndex(1)?.secureTextEntry = false
        alert.textFieldAtIndex(0)?.placeholder = "From"
        alert.textFieldAtIndex(1)?.placeholder = "To"
        
        alert.show()
        
        
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 0{
            
            // Clear old annotations
            if let ex = mkTrip.annotations {
                mkTrip.removeAnnotations(ex)
            }
            if let ey = mkTrip.overlays{
                mkTrip.removeOverlays(ey)
            }
            
            tfFrom = alertView.textFieldAtIndex(0)?.text
            tfTo = alertView.textFieldAtIndex(1)?.text
            
            tfFrom = tfFrom?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            tfTo = tfTo?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            if(tfFrom == nil || (countElements(tfFrom!) == 0) || tfTo == nil || countElements(tfTo!) == 0)
            {
                
                println("enter to and from")
                return
            }
            
            self.mkTrip.clearsContextBeforeDrawing = true
            
            mapManager.directionsUsingGoogle(from: tfFrom!, to: tfTo!) { (route,directionInformation, boundingRegion, error) -> () in
                
                if(error != nil){
                    
                    println(error)
                }else{
                    
                    var pointOfOrigin = MKPointAnnotation()
                    pointOfOrigin.coordinate = route!.coordinate
                    pointOfOrigin.title = directionInformation?.objectForKey("start_address") as NSString
                    pointOfOrigin.subtitle = directionInformation?.objectForKey("duration") as NSString
                    
                    var pointOfDestination = MKPointAnnotation()
                    pointOfDestination.coordinate = route!.coordinate
                    pointOfDestination.title = directionInformation?.objectForKey("end_address") as NSString
                    pointOfDestination.subtitle = directionInformation?.objectForKey("distance") as NSString
                    
                    var start_location = directionInformation?.objectForKey("start_location") as NSDictionary
                    self.originLat = start_location.objectForKey("lat")?.doubleValue
                    self.originLng = start_location.objectForKey("lng")?.doubleValue
                    
                    var end_location = directionInformation?.objectForKey("end_location") as NSDictionary
                    self.destLat = end_location.objectForKey("lat")?.doubleValue
                    self.destLng = end_location.objectForKey("lng")?.doubleValue
                    
                    var coordOrigin = CLLocationCoordinate2D(latitude: self.originLat!, longitude: self.originLng!)
                    var coordDesitination = CLLocationCoordinate2D(latitude: self.destLat!, longitude: self.destLng!)
                    
                    pointOfOrigin.coordinate = coordOrigin
                    pointOfDestination.coordinate = coordDesitination
                    
                    if let web = self.mkTrip{
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            web.addOverlay(route!)
                            web.addAnnotation(pointOfOrigin)
                            web.addAnnotation(pointOfDestination)
                            web.setVisibleMapRect(boundingRegion!, animated: true)
                            
                            self.steps = directionInformation?.valueForKey("steps") as NSArray
                            
//                                        let amm = self.mkTrip.annotations
//                                        self.mkTrip.showAnnotations(amm, animated: true)
//                                        self.mkTrip.camera.altitude *= 1.0
                            
//                            //fit size map
//                            var zoomRect = MKMapRectNull
//                            var myLocationPointRect = MKMapRectMake(self.originLng, self.originLat, 0.0, 0.0)
//                            var currentDestinationPointRect = MKMapRectMake(self.destLng, self.destLat, 0.0, 0.0)
//                            
//                            zoomRect = myLocationPointRect
//                            zoomRect = MKMapRectUnion(zoomRect, currentDestinationPointRect)
//                            
//                            self.mkTrip.setVisibleMapRect(zoomRect, animated: true)
                            var zoomRect: MKMapRect = MKMapRectNull
                            var annotations = self.mkTrip.annotations as  [MKAnnotation]
                            for annotation in annotations {
                                var annotationPoint: MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
                                var pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1) as  MKMapRect
                                if (MKMapRectIsNull(zoomRect)) {
                                    zoomRect = pointRect
                                } else {
                                    zoomRect = MKMapRectUnion(zoomRect, pointRect)
                                }
                            }
                            self.mkTrip.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsetsMake(50, 50, 50, 50) , animated: true)
                            
                            }
                        
                        self.routeDone = true
                        
                        self.navigationItem.rightBarButtonItem?.enabled = true
                        }
                        
                    }
    
                }
    
            }

    }
    
    func getArrayLatLngFromSteps (steps: NSArray) -> NSMutableArray{
        
        var result: NSMutableArray = []
        
        for step in steps{
            result.addObject(step.valueForKey("end_location")!)
            result.addObject(step.valueForKey("start_location")!)
//            result = result + step.valueForKey("end_location")
//            result = result + step.valueForKey("start_location")
        }
        
        return result
    }
    
    func getCityFromLatLng(lat: Double, lng: Double){
        
        let location: CLLocation = CLLocation(latitude: lat, longitude: lng)
        let geoCoder = CLGeocoder()
        
        var result = ""
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {
            (placeMarks, error) -> Void in
            
            let placeArray = placeMarks as [CLPlacemark]
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray[0]
            
//            // Address dictionary
//            println(placeMark.addressDictionary)
//            
//            // Location name
//            if let locationName = placeMark.addressDictionary["Name"] as? NSString {
//                println("locName",locationName)
//            }
//            
//            // Street address
//            if let street = placeMark.addressDictionary["Thoroughfare"] as? NSString {
//                println("street",street)
//            }
//            
            // City
            if let city = placeMark.addressDictionary["City"] as? NSString {
                println("city",city)
                self.getCity(city)
            }
            
//            // Zip code
//            if let zip = placeMark.addressDictionary["ZIP"] as? NSString {
//                println("zip",zip)
//            }
//            
//            // Country
//            if let country = placeMark.addressDictionary["Country"] as? NSString {
//                println("country",country)
//            }
            
        })
        
    }
    
    func getCity(result: NSString){
        
        self.cities.addObject(result)
    
        
    }

    
    override func viewWillAppear(animated: Bool) {
//        btnNext = UIButton()
//        btnNext.setImage(UIImage(named: "chevron-double-right.png"), forState:UIControlState.Normal)
//        btnNext.targetForAction("next", withSender: nil)
//        let tem = self.navigationItem.leftBarButtonItem?.customView?.frame
//        btnNext.frame = tem!
//        self.navigationItem.rightBarButtonItem?.customView = btnNext
    }
    
    func mapViewWillStartLocatingUser(mapView: MKMapView!) {
        
    }
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 5
            println("done")
            return polylineRenderer
        }
        
        return nil
    }
    
    

    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var hasAuthorised = false
            var locationStatus:NSString = ""
            var verboseKey = status
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access"
            case CLAuthorizationStatus.Denied:
                locationStatus = "Denied access"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Not determined"
            default:
                locationStatus = "Allowed access"
                hasAuthorised = true
            }
            
            
            
            if(hasAuthorised == true){
                
//                getDirectionsUsingApple()
                
            }else {
                
                println("locationStatus \(locationStatus)")
                
            }
            
    }

    
}
