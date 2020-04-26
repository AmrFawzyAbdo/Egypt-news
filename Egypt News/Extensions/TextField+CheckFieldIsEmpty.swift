//
//  TextField+CheckFieldIsEmpty.swift
//  BlueRide
//
//  Created by AnDy on 7/17/19.
//  Copyright © 2019 Ibrahim. All rights reserved.
//

import UIKit

extension UITextField {
    
    func checkTextFieldIsEmpty (myText : UITextField , errorMessage : String ,actionTitle : String , myViewController : UIViewController) {
        guard let myText = myText.text , myText.isEmpty == false else {
            myViewController.showAltertControllerWithAction(title: "Error", message: errorMessage, altertStyle: .alert, actionTitle: "Dismiss", actionStyle: .default)
            return
        }
    }
    func changeBorderColor(bordeWidth : CGFloat , borderColor : CGColor){
        self.layer.borderWidth = bordeWidth
        self.layer.borderColor = borderColor
    }
    
}
