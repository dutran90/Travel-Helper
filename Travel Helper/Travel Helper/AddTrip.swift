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
    
    var btnNext : UIButton!
    
    var titView = UIView()
    
    var routeDone = false
    
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
        
        let l = alert.valueForKey("_titleLabel") as UILabel
        println(l.text)
        
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 0{
            tfFrom = alertView.textFieldAtIndex(0)?.text
            tfTo = alertView.textFieldAtIndex(1)?.text
            self.routeDone = true
            
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
                    var originLat = start_location.objectForKey("lat")?.doubleValue
                    var originLng = start_location.objectForKey("lng")?.doubleValue
                    
                    var end_location = directionInformation?.objectForKey("end_location") as NSDictionary
                    var destLat = end_location.objectForKey("lat")?.doubleValue
                    var destLng = end_location.objectForKey("lng")?.doubleValue
                    
                    var coordOrigin = CLLocationCoordinate2D(latitude: originLat!, longitude: originLng!)
                    var coordDesitination = CLLocationCoordinate2D(latitude: destLat!, longitude: destLng!)
                    
                    pointOfOrigin.coordinate = coordOrigin
                    pointOfDestination.coordinate = coordDesitination
                    if let web = self.mkTrip{
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            web.addOverlay(route!)
                            web.addAnnotation(pointOfOrigin)
                            web.addAnnotation(pointOfDestination)
                            web.setVisibleMapRect(boundingRegion!, animated: true)
                        }
                        
                    }
                    
                }
            }

            
        }
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
