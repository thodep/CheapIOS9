//
//  ReviewViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-06.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit
import Parse // to save rating on Parse

class ReviewViewController: UIViewController , UIAlertViewDelegate{

    @IBOutlet weak var badRating: ButtonStyle!
    
    @IBOutlet weak var goodRating: ButtonStyle!
    
    @IBOutlet weak var closeButton: ButtonStyle!
    
    @IBOutlet weak var bgroundView: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.alpha = 0.4
        bgroundView.alpha = 0.91
        bgroundView.layer.cornerRadius = 12
        bgroundView.layer.masksToBounds = true
        
        // Adding animation into bgroundView
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        bgroundView.transform = CGAffineTransformConcat(scale, translate)
       
    }
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6,
        initialSpringVelocity: 0.5, options: [], animations: {
        let scale = CGAffineTransformMakeScale(1, 1)
        let translate = CGAffineTransformMakeTranslation(0, 0)
        self.bgroundView.transform = CGAffineTransformConcat(scale, translate)
        }, completion: nil)
        
        super.viewDidAppear(true)
    }
    
    @IBAction func happButtonPressed(sender: AnyObject) {
        let uiAlert = UIAlertController(title: "Awesome", message: "Thanks for your good rating", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)

        uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            print("Click of default button")
            print("Saved on Parse")
            // to go back to detailVC
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
    }
    
    
    @IBAction func unHappyButtonPressed(sender: AnyObject) {
        let uiAlert = UIAlertController(title: "Great", message: "Thanks for your feedback", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            print("Click of default button")
            print("Saved on Parse")
             // to go back to detailVC
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
