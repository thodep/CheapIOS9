//
//  ReviewViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-06.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit
import Parse // to save rating on Parse

class ReviewViewController: UIViewController , UIAlertViewDelegate {

    @IBOutlet weak var badRating: ButtonStyle!
    
    @IBOutlet weak var goodRating: ButtonStyle!
    
    @IBOutlet weak var closeButton: ButtonStyle!
    
    @IBOutlet weak var bgroundView: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var activities: [PFObject]?
    var currentResturant: Business?
    
    var isItCheap : Bool?
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
            
            // to go back to detailVC
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
        isItCheap = true
        cheapOrNot()
    }
    
    
    @IBAction func unHappyButtonPressed(sender: AnyObject) {
        let uiAlert = UIAlertController(title: "Great", message: "Thanks for your feedback", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            print("Click of default button")
          
             // to go back to detailVC
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
        isItCheap = false
        cheapOrNot()
    }
    // Function to save customer rating on Parse
    func cheapOrNot(){
        if let currentRest = currentResturant {
            // Create a PF Class Object called CheapOrNotReview
        let review = PFObject(className: "CheapOrNotReview")
    
          // We create cheap and userID objects into the CheapOrNotReview Class
        review["cheap"] = isItCheap
        review["restaurantName"] = currentRest.name
        review["userID"] =  PFUser.currentUser()
           // Save the PFObject in background
            review.saveInBackgroundWithBlock({ (success, error: NSError?) -> Void in
                if (error != nil ){
                 print(error)
                
                } else {
                    print("review added ")
                }
          })
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
