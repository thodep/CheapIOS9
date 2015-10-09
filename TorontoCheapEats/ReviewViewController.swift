//
//  ReviewViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-06.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController , UIAlertViewDelegate{

    @IBOutlet weak var badRating: ButtonStyle!
    
    @IBOutlet weak var goodRating: ButtonStyle!
    
    @IBOutlet weak var closeButton: ButtonStyle!
    
    @IBOutlet weak var bgroundView: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func happButtonPressed(sender: AnyObject) {
        let uiAlert = UIAlertController(title: "Awesome", message: "Thanks for your good rating", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)

        uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            print("Click of default button")
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
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
    }
    
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
