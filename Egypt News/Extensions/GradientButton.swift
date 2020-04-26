//
//  GradientButton.swift
//  BlueRide
//
//  Created by AnDy on 7/14/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import UIKit

@IBDesignable
public class GradientButton: UIButton {
    
    let gradientLayer = CAGradientLayer()
//    let shadowLayer = CAShapeLayer()
    
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable
    var startPointX: CGFloat = 0 {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable
    var startPointY: CGFloat = 0 {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable
    var endPointX: CGFloat = 1 {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable
    var endPointY: CGFloat = 0 {
        didSet {
            setGradient()
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
//            self.layer.masksToBounds = false
            self.layer.cornerRadius = cornerRadius
//            self.clipsToBounds = true
             setGradient()
         }
    }
    
    
     @IBInspectable var shadowOpacity:CGFloat = 0.0{
        didSet{
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    @IBInspectable var shadowColor:UIColor = UIColor.clear  {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius:CGFloat = 0{
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffsetY:CGFloat = 0{
        didSet{
            self.layer.shadowOffset.height = shadowOffsetY
        }
    }
     private func setGradient() {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
            gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            
            layer.insertSublayer(gradientLayer, at: 0)

        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}
