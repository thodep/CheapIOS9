//
//  ButtonStyle.swift
//  BuddyUp
//
//  Created by Yung Dai on 2015-07-03.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

@IBDesignable class ButtonStyle: UIButton {
    
    @IBInspectable var cornerRounding: CGFloat = 0 {
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
        buttonStyle()
    }
    
    override func awakeFromNib() {
        buttonStyle()
    }
    
    func buttonStyle() {
        layer.cornerRadius = cornerRounding
        layer.borderWidth = BorderWidth
        layer.borderColor = BorderColour?.CGColor
    }
}
