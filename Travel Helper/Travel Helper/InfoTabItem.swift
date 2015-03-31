//
//  InfoTabItem.swift
//  Travel Helper
//
//  Created by Yosemite on 3/24/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import Foundation
import UIKit

class InfoTabItem: UIViewController {
    
    @IBOutlet weak var item1: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let screenBound = UIScreen.mainScreen().bounds
        let screenSize = screenBound.size
        let imgView = RBResizeImage(UIImage(named: "bg_ip6.jpg")!, screenSize)
        
        self.view.backgroundColor = UIColor(patternImage: imgView)
        
        let a = DetailTabView()
        print(a.checkNew)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}