//
//  ReviewViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-06.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var bgroundView: UIView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var notCheapButton: UIButton!
    
    @IBOutlet weak var cheapButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding animtation to the review controller
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        bgroundView.transform = CGAffineTransformConcat(scale, translate)
        
        // modify Close Button
        closeButton.layer.cornerRadius = 17
        closeButton.layer.masksToBounds = true
         closeButton.alpha = 0.6
        // modify the backgroundView 
        bgroundView.layer.cornerRadius = 10
        bgroundView.layer.masksToBounds = true
        
        // modify Not Cheap Button
        notCheapButton.layer.cornerRadius = 31
        notCheapButton.layer.masksToBounds = true
        notCheapButton.alpha = 0.8
        // Modify Cheap Button
        cheapButton.layer.cornerRadius = 31
        cheapButton.layer.masksToBounds = true
        cheapButton.alpha = 0.8
       
        // Blur the background 
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.75
        blurEffectView.frame = view.bounds
      
        backgroundImageView.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
        
    }
    // Happy Rating from Customer
    @IBAction func happyRating(sender: AnyObject) {
        let uiAlert = UIAlertController(title: "Awesome!", message: "Thanks For Good Rating !! ", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)
       
        
        uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            print("got customer rating save on Parse")
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
        
        
    }
    // Bad Rating from Customer
    
    @IBAction func unHappyRating(sender: AnyObject) {
        
            let uiAlert = UIAlertController(title: "Opps", message: "Thanks for your feedback", preferredStyle: UIAlertControllerStyle.Alert)
        
            self.presentViewController(uiAlert, animated: true, completion: nil)
      
        
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                print("got customer rating save on Parse")
            }))
            
            uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
                print("Click of cancel button")
            }))
        // how to dimiss the view from main view
        
       // self.bgroundView.removeFromSuperview()
        //self.closeButton.removeFromSuperview()
       // performSegueWithIdentifier(identifier: String, sender: AnyObject?)
    }
    
    override func viewDidAppear(animated: Bool) {
        //  Add Spring animation and Slide Up Animation
            UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.bgroundView.transform = CGAffineTransformConcat(scale, translate)
            }, completion: nil)
    }
    
    // Using UiAlertController to rate the restaurant
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
