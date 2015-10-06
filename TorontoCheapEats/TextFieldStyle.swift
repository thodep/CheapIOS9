//
//  TextFieldStyle.swift
//  BuddyUp
//
//  Created by Yung Dai on 2015-07-03.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

@IBDesignable class TextFieldStyle: UITextField {
    
    @IBInspectable var cornerRounding: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRounding
            
        }
    }
    
    @IBInspectable var BorderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = BorderWidth
            
        }
    }
    
    
    
    @IBInspectable var BorderColour: UIColor? {
        didSet {
            layer.borderColor = BorderColour?.CGColor
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        textFieldStyle()
    }
    
    override func awakeFromNib() {
        textFieldStyle()
    }
    
    func textFieldStyle() {
        layer.cornerRadius = cornerRounding
        layer.borderWidth = BorderWidth
        layer.borderColor = BorderColour?.CGColor
        
    }
    
    
}
