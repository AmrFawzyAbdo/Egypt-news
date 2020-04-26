//
//  Indicator.swift
//  BlueRideDriver
//
//  Created by Apple on 2/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showHUD(_ message:String = "Loading"){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.contentMode = .center
        progressHUD.label.text = message
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showMessage(_ message:String){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.contentMode = .bottom
        progressHUD.label.text = message
        progressHUD.label.numberOfLines = 0
        progressHUD.mode = .text
        
        run(after: 2) {
            UIView.animate(withDuration: 0.6, animations: {
                progressHUD.alpha = 0
            }, completion: { (success) in
                progressHUD.hide(animated: true)
            })
            
        }
        
    }
}
