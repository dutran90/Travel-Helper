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

class AddTrip : UIViewController, MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mkTrip: MKMapView!
    
    var mapManager = MapManager()
    
    var locationManager: CLLocationManager!
    
    var tfFrom = UITextField()
    
    var tfTo = UITextField()
    
    var btnNext : UIButton!
    
    var titView = UIView()
    
    override func viewDidLoad() {
        
        let screenBound = UIScreen.mainScreen().bounds
        let screenSize = screenBound.size
        
        let t = self.navigationController?.navigationBar.frame.size.height
        
        let h = screenSize.height - t!
        
        mkTrip.frame.size = CGSize(width: screenSize.width, height: h)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevron-double-right.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "next")
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevron-double-left.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        
        
        func UIColorFromRGB(rgbValue: UInt) -> UIColor {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        let sizeWidth = self.navigationController?.navigationBar.frame.size.width
        let sizeHeight = self.navigationController?.navigationBar.frame.size.height

        titView.frame.size = CGSize(width: sizeWidth!/2, height: sizeHeight!)
        let img = RBResizeImage(UIImage(named: "map-marker-radius.png")!, titView.frame.size)
        let imgV = UIImageView(image: img)
        imgV.image = imgV.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imgV.tintColor = UIColorFromRGB(10931807)
        imgV.center = CGPoint(x: sizeWidth!/4, y: sizeHeight!/2)
        titView.addSubview(imgV)
        self.navigationItem.titleView = titView
        self.animateButtonRoute()
        self.navigationItem.rightBarButtonItem?.enabled = false
        
//        self.animateButtonNext()
        
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

    
    override func viewWillAppear(animated: Bool) {
//        btnNext = UIButton()
//        btnNext.setImage(UIImage(named: "chevron-double-right.png"), forState:UIControlState.Normal)
//        btnNext.targetForAction("next", withSender: nil)
//        let tem = self.navigationItem.leftBarButtonItem?.customView?.frame
//        btnNext.frame = tem!
//        self.navigationItem.rightBarButtonItem?.customView = btnNext
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
