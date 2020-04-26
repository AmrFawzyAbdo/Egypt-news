//
//  TabBar.swift
//  Egypt News
//
//  Created by Apple on 4/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    @IBOutlet weak var tab: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TAAAAAAAAAAAAAAAAAB")
        
        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for:.normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for:.selected)
        
        
        
        self.tabBar.isTranslucent = true
        self.tabBar.alpha = 1
        self.tabBar.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        self.tabBar.layer.backgroundColor = UIColor.clear.withAlphaComponent(0.0).cgColor
        self.tabBar.backgroundImage = nil
        self.tabBar.shadowImage = nil
        
        
//        let blur = UIBlurEffect(style: UIBlurEffect.Style.light)
//
//        let blurView = UIVisualEffectView(effect: blur)
//        self.view.addSubview(blurView)
//        blurView.frame = self.tabBar.bounds


        
//        UITabBar.appearance().barTintColor = UIColor.clear

        






    }
    

   

}
