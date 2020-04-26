//
//  ViewController+AltertView.swift
//  Music Player
//
//  Created by AnDy on 7/8/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAltertControllerWithAction(title : String , message : String, altertStyle : UIAlertController.Style , actionTitle :String  , actionStyle : UIAlertAction.Style , completion: ((UIAlertAction)-> Void)? = nil){
        
        let altertViewController = UIAlertController(title: title, message: message, preferredStyle: altertStyle)
        let action1 = UIAlertAction(title: actionTitle, style: actionStyle) { (action) in
            if let completion = completion{
                completion(action)
            }
         }
        altertViewController.addAction(action1)
        self.present(altertViewController, animated: true , completion: nil)
    }
}
