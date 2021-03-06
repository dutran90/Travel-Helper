//
//  DetailTabView.swift
//  Travel Helper
//
//  Created by Yosemite on 3/24/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import Foundation
import UIKit

class DetailTabView: UITabBarController, UITabBarControllerDelegate {
    @IBOutlet weak var tbDetail: UITabBar!
    
    var checkNew : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tbDetail2 = self.tabBar

        var item = tbDetail.items as [UITabBarItem]
        
        let y = tbDetail.frame.height
        item[0].image = RBResizeImage(UIImage(named:"Home-50.png")!, CGSize(width: y-20, height: y-20))
        item[1].image = RBResizeImage(UIImage(named:"Music-50.png")!, CGSize(width: y-20, height: y-20))
        item[2].image = RBResizeImage(UIImage(named:"Opened Folder Filled-50.png")!, CGSize(width: y-20, height: y-20))
        
    }
    
    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitioningObject: TransitioningObject = TransitioningObject()
        // set the reference to self so it can get the indexes of the to and from view controllers
        transitioningObject.tabBarController = self
        return transitioningObject
    }

}
class TransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
    private weak var tabBarController: DetailTabView!
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Get the "from" and "to" views
        let fromView: UIView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let fromViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toView: UIView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let toViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        transitionContext.containerView().addSubview(fromView)
        transitionContext.containerView().addSubview(toView)
        
        let fromViewControllerIndex = find(self.tabBarController.viewControllers! as [UIViewController], fromViewController)
        let toViewControllerIndex = find(self.tabBarController.viewControllers! as [UIViewController], toViewController)
        
        // 1 will slide left, -1 will slide right
        var directionInteger: CGFloat!
        if fromViewControllerIndex < toViewControllerIndex {
            directionInteger = 1
        } else {
            directionInteger = -1
        }
        
        //The "to" view with start "off screen" and slide left pushing the "from" view "off screen"
        toView.frame = CGRectMake(directionInteger * toView.frame.width, 0, toView.frame.width, toView.frame.height)
        let fromNewFrame = CGRectMake(-1 * directionInteger * fromView.frame.width, 0, fromView.frame.width, fromView.frame.height)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            toView.frame = fromView.frame
            fromView.frame = fromNewFrame
            }) { (Bool) -> Void in
                // update internal view - must always be called
                transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.33
    }
}