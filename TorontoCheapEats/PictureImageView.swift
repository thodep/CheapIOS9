//
//  PictureImageView.swift
//  BuddyUp
//
//  Created by Yung Dai on 2015-06-21.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

@IBDesignable class PictureImageView: UIImageView {
    
    
    @IBInspectable var cornerRounding: CGFloat = 50{
        didSet {
            layer.cornerRadius = cornerRounding
            
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
            
        }
    }
    

    
    @IBInspectable var borderColour: UIColor? {
        didSet {
            layer.borderColor = borderColour?.CGColor
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        personImageStyle()
    }
    
    override func awakeFromNib() {
        personImageStyle()
    }
    
    func personImageStyle() {
        layer.cornerRadius = cornerRounding
        layer.borderWidth = borderWidth
        layer.borderColor = borderColour?.CGColor
        // binds the masking to the variables above.  This will be true for all images assigned in IB
        layer.masksToBounds = true
    }
    
}
