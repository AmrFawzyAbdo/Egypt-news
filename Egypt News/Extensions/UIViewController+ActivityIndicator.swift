//
//  Spinner.swift
//  Music Player
//
//  Created by AnDy on 7/8/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import Foundation
import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let  spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicaror = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicaror.startAnimating()
        activityIndicaror.center = spinnerView.center
        
        spinnerView.addSubview(activityIndicaror)
        onView.addSubview(spinnerView)
        
        vSpinner = spinnerView
        
        //        run(after: 10.0 ) {
        //            self.removeSpinner()
        //            return
        //        }
    }
    
    func removeSpinner() {
        vSpinner?.removeFromSuperview()
        vSpinner = nil
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    
}
