//
//  TextField.swift
//  BlueRide
//
//  Created by Ibrahim on 7/11/19.
//  Copyright © 2019 Ibrahim. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {
    
    
    @IBInspectable var cornerRadius:CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.black  {
        didSet{
            self.layer.borderColor = borderColor.cgColor
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
    @IBInspectable var rightImage : UIImage? {
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        if let image = rightImage {
            let imageView:UIImageView!
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            
            let gestureRecognizer = rightView?.gestureRecognizers?[0]
            
            let view =  UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 25))
            if gestureRecognizer != nil {
                view.addGestureRecognizer(gestureRecognizer!)
            }
            view.addSubview(imageView)
            rightView = view
            rightViewMode = .always
            
            
        }else{
            rightViewMode = .never
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.borderStyle = .none
        self.layer.cornerRadius = 24
        
        self.layer.shadowOpacity = 2

        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.04)
        self.layer.shadowRadius = 12
        self.layer.shadowOffset.height = 7
        addPadding()
        changeFont()
        
    }
    func changeFont(){
        
        guard let customFont = UIFont(name: "Lato-Light", size: 22) else {
            return
        }
        self.font = UIFontMetrics.default.scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
        
    }
    
    func addPadding(){
        let paddingView =  UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
}
