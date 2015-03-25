//
//  ViewController.swift
//  Travel Helper
//
//  Created by Yosemite on 3/22/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var foot0: UIImageView!
    @IBOutlet weak var foot1: UIImageView!
    @IBOutlet weak var foot2: UIImageView!
    @IBOutlet weak var foot3: UIImageView!
    @IBOutlet weak var foot4: UIImageView!
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var btnGo: UIButton!
    
    var btnGo1: AYVibrantButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenBound = UIScreen.mainScreen().bounds
        let screenSize = screenBound.size
        let imgView = RBResizeImage(UIImage(named: "bg_ip6.jpg")!, screenSize)
        
        self.view.backgroundColor = UIColor(patternImage: imgView)
        
        imgViewLogo.image = UIImage(named: "logo.png")
        foot0.image = UIImage(named: "Left Footprint Filled-50.png")
        foot1.image = UIImage(named: "Right Footprint Filled-50.png")
        foot2.image = UIImage(named: "Left Footprint Filled-50.png")
        foot3.image = UIImage(named: "Right Footprint Filled-50.png")
        foot4.image = UIImage(named: "Left Footprint Filled-50.png")
        
        foot0.hidden = true
        foot1.hidden = true
        foot2.hidden = true
        foot3.hidden = true
        foot4.hidden = true
        self.animateButton0()
        
        let cgrect = CGRect(origin: CGPoint(x:screenSize.width/2-60, y:screenSize.height/2-30), size: CGSize(width: 120, height: 60))
        btnGo1 = AYVibrantButton(frame: cgrect, style: AYVibrantButtonStyleInvert)
        btnGo1.vibrancyEffect = UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        btnGo1.text = "LET'S GO!"
        btnGo1.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(btnGo1)
        btnGo1.hidden = true
        btnGo1.addTarget(self, action: "letGo", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func letGo(){
        println("Call MainVC")
        self.performSegueWithIdentifier("letGoSegue", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ⬇︎⬇︎⬇︎ animation happens here ⬇︎⬇︎⬇︎
    func animateButton0() {
        foot0.hidden = false
        foot0.transform = CGAffineTransformMakeScale(0.1, 0.1)

        UIView.animateWithDuration(0.3,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.foot0.transform = CGAffineTransformIdentity

            },
            completion: { finished in
                self.foot0.layer.removeAllAnimations()
                self.animateButton1()
            }
        )
    }
    func animateButton1() {
        foot1.hidden = false
        foot1.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(0.3,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.foot1.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                self.foot1.layer.removeAllAnimations()
                self.animateButton2()
            }
        )
    }
    func animateButton2() {
        foot2.hidden = false
        foot2.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(0.3,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.foot2.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                self.foot2.layer.removeAllAnimations()
                self.animateButton3()
            }
        )
    }

    func animateButton3() {
        foot3.hidden = false
        foot3.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(0.3,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.foot3.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                self.foot3.layer.removeAllAnimations()
                self.animateButton4()
            }
        )
    }
    func animateButton4() {
        foot4.hidden = false
        foot4.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(0.3,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.foot4.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                self.foot3.layer.removeAllAnimations()
                self.animateButtonLogo()
            }
        )
    }
    
    func animateButtonLogo() {

        imgViewLogo.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.imgViewLogo.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                self.imgViewLogo.layer.removeAllAnimations()
                self.foot0.hidden = true
                self.foot1.hidden = true
                self.foot2.hidden = true
                self.foot3.hidden = true
                self.foot4.hidden = true
                self.animateButtonGo()
            }
        )
    }

    func animateButtonGo() {
        
        btnGo1.hidden = false
        btnGo1.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.2),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.btnGo1.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                self.animateButtonGo()
            }
        )
    }

    
}

