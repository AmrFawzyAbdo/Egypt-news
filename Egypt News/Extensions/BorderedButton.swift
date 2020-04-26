//
//  BorderedButton.swift
//  BlueRide
//
//  Created by AnDy on 7/16/19.
//  Copyright © 2019 Ibrahim. All rights reserved.
//

import UIKit

@IBDesignable class BorderedButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            
            setGradient()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        didSet {
            setGradient()
        }
    }
    
    private func setGradient() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        
    }
    
    
}
