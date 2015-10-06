//
//  BackgroundView.swift
//  BuddyUp
//
//  Created by Yung Dai on 2015-06-25.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

@IBDesignable class BackgroundView: UIView {
    
    // MARK: Inspectable properties ******************************
    
    @IBInspectable var viewColour: UIColor = UIColor.grayColor() {
        didSet {
            backgroundColor = viewColour
        }
    }
    
    @IBInspectable var useGradient: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var StartColor: UIColor = UIColor.whiteColor()
    @IBInspectable var EndColor: UIColor = UIColor.blackColor()
    @IBInspectable var isHorizontal: Bool = false {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var roundness: CGFloat = 10.0
    
    // MARK: Internal functions *********************************
    
    // Setup the view appearance
    private func setupView(){
        
        if (useGradient) {
            let colors:Array = [StartColor.CGColor, EndColor.CGColor]
            gradientLayer.colors = colors
            gradientLayer.cornerRadius = roundness
            self.setNeedsDisplay()
        }
        
        
        if (isHorizontal){
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }else{
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        
        
    }
    
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

    
    // Helper to return the main layer as CAGradientLayer
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    // MARK: Overrides ******************************************
    
    override class func layerClass()->AnyClass{
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    
    func viewStyle() {
        backgroundColor = viewColour
        layer.borderWidth = BorderWidth
        layer.borderColor = BorderColour?.CGColor
        layer.cornerRadius = cornerRounding
        setupView()
    }
    
    
    
}
