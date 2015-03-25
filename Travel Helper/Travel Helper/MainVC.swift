//
//  MainVC.swift
//  Travel Helper
//
//  Created by Yosemite on 3/22/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import Foundation
import UIKit

class MainVC: UICollectionViewController {
    
    @IBOutlet weak var navItemTrip: UINavigationItem!
    var btnAdd: UIBarButtonItem!
    var btnClose: UIBarButtonItem!
    @IBOutlet weak var cvTrip: UICollectionView!
    
    var isClose: Bool = false
    var Trips = Array<String>()
    var NameTrips = Array<String>()
    var TimeTrips = Array<String>()
    
    var direction: CGFloat = 1.0
    
    override func viewDidLoad() {
        
        
        let screenBound = UIScreen.mainScreen().bounds
        let screenSize = screenBound.size
        let imgView = RBResizeImage(UIImage(named: "bg_ip6.jpg")!, screenSize)
        
        self.view.backgroundColor = UIColor(patternImage: imgView)
    
        navItemTrip.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: nil, action: nil)
        navItemTrip.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "EditTripPressed")
        
        let sizeWidth = self.navigationController?.navigationBar.frame.size.width
        let sizeHeight = self.navigationController?.navigationBar.frame.size.height
        let titView = UIView()
        titView.frame.size = CGSize(width: sizeWidth!/2, height: sizeHeight!)
        let img = RBResizeImage(UIImage(named: "yourTrip.png")!, titView.frame.size)
        let imgV = UIImageView(image: img)
        imgV.center = CGPoint(x: sizeWidth!/4, y: sizeHeight!/2+5)
        titView.addSubview(imgV)
        navItemTrip.titleView = titView

        
        cvTrip.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        cvTrip.frame.origin = CGPoint(x: 0, y: 0)
        cvTrip.backgroundColor = UIColor.clearColor()

        self.view.addSubview(cvTrip)
        
        Trips = ["trip.jpg","trip.jpg","trip.jpg","trip.jpg","trip.jpg","trip.jpg","trip.jpg","trip.jpg","trip.jpg"]
        NameTrips = ["Da Nang - Sai Gon1","Da Nang - Sai Gon2","Da Nang - Sai Gon3","Da Nang - Sai Gon4","Da Nang - Sai Gon5","Da Nang - Sai Gon6","Da Nang - Sai Gon7","Da Nang - Sai Gon8","Da Nang - Sai Gon9"]
        TimeTrips = ["12-12-2015","12-12-2015","12-12-2015","12-12-2015","12-12-2015","12-12-2015","12-12-2015","12-12-2015","12-12-2015"]
        

        
    }
    
    func EditTripPressed() {

        if(isClose == false){
            
//            for item in self.cvTrip!.visibleCells() as [TripCell] {
//                
//                var indexpath : NSIndexPath = self.cvTrip!.indexPathForCell(item as TripCell)!
//                var cell : TripCell = self.cvTrip!.cellForItemAtIndexPath(indexpath) as TripCell
//                
//                //Profile Picture
//                //var img : UIImageView = cell.viewWithTag(100) as UIImageView
//                //img.image = UIImage(named: "q.png") as UIImage
//                
//                //Close Button
////                var close : UIButton = cell.viewWithTag(102) as UIButton
////                close.hidden = false
                self.cvTrip?.reloadData()
                isClose = true
            navItemTrip.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "EditTripPressed")
//            }
        } else {
            isClose = false
            self.cvTrip?.reloadData()
            navItemTrip.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "EditTripPressed")
        }
    }
    
    func shakeToDelete(shakeMe: UICollectionViewCell){
        var theDelay: NSTimeInterval = 0.1
        UICollectionViewCell.animateWithDuration(theDelay,
            animations: {
                shakeMe.transform = CGAffineTransformMakeRotation(0.02 * self.direction)
            },
            completion: { finished in
                self.direction = self.direction * -1
                self.shakeToDelete(shakeMe)
            }
        )

    }
    func flyToTrash(flyMe: UICollectionViewCell){
        let cg = CGRect(x: 20, y: 0, width: 10, height: 0)
        let duration: NSTimeInterval = 1.0
        flyMe.genieInTransitionWithDuration(duration, destinationRect: cg, destinationEdge: BCRectEdge.Bottom, completion: {
            println("Trip deleted!")
            self.isClose = false
            self.cvTrip!.reloadData()
            self.navItemTrip.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "EditTripPressed")
            })
    }

    // #pragma mark UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        return Trips.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /*
        We can use multiple way to create a UICollectionViewCell.
        */
        
        
        //1.
        //We can use Reusablecell identifier with custom UICollectionViewCell
        
        /*
        let cell = collectionView!.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        
        var AlbumImage : UIImageView = cell.viewWithTag(100) as UIImageView
        AlbumImage.image = UIImage(named: Albums[indexPath.row])
        */
        
        
        
        //2.
        //You can create a Class file for UICollectionViewCell and Set the appropriate component and assign the value to that class
        
        let cell : TripCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as TripCell
        let fxBlur = FXBlurView(frame: cell.frame)
        fxBlur.backgroundColor = UIColor.clearColor()
        cell.backgroundView = fxBlur
        cell.layer.cornerRadius = 12.0

        cell.TripImage?.image = UIImage(named: Trips[indexPath.row])
        cell.TripImage?.layer.masksToBounds = true
        cell.TripImage?.layer.cornerRadius = 12.0
        
        cell.lbNameTrip.text = NameTrips[indexPath.row]
        cell.lbTimeTrip.text = TimeTrips[indexPath.row]
        
        if isClose == false {
            cell.CloseImage?.hidden = true
            cell.transform = CGAffineTransformMakeRotation(0)
            let gesture = UITapGestureRecognizer(target: self, action: "callSegue")
            cell.lbNameTrip.userInteractionEnabled = true
            cell.lbNameTrip.addGestureRecognizer(gesture)
        } else {
            cell.CloseImage?.hidden = false
            cell.lbNameTrip.userInteractionEnabled = false
            if indexPath.row % 2 == 0{
                cell.transform = CGAffineTransformMakeRotation(0.04)
            }else{
                cell.transform = CGAffineTransformMakeRotation(-0.04)
            }

        }
        
        //Layer property in Objective C => "http://iostutorialstack.blogspot.in/2014/04/how-to-assign-custom-tag-or-value-to.html"
        cell.CloseImage?.layer.setValue(indexPath.row, forKey: "index")
        
        
        cell.CloseImage?.addTarget(self, action: "deletePhoto:", forControlEvents: UIControlEvents.TouchUpInside)

        
        return cell
    }
    
    func deletePhoto(sender:UIButton) {
        let i : Int = (sender.layer.valueForKey("index")) as Int
        Trips.removeAtIndex(i)
        NameTrips.removeAtIndex(i)
        TimeTrips.removeAtIndex(i)
        let cell: UICollectionViewCell = sender.superview as UICollectionViewCell
        self.flyToTrash(cell)
    }
    
    func callSegue(){
        self.performSegueWithIdentifier("tripDetailSegue", sender: 1)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tripDetailSegue"{
        }
    }
    
}