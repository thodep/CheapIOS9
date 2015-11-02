//
//  AbouMeVC.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-25.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit
import MessageUI

class AbouMeVC: UIViewController, MFMailComposeViewControllerDelegate, UINavigationBarDelegate {

    @IBOutlet weak var imageView: PictureImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       imageView.animationImages = [
        UIImage(named: "Question-Mark_V0")!,
        UIImage(named: "Question-Mark_V2")!,
        UIImage(named: "Question-Mark_V1")!,
        UIImage(named: "Question-Mark_V3")!
        ]
        imageView.animationDuration = 2
        imageView.startAnimating()
    }

    @IBAction func sendEmail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            
            composer.mailComposeDelegate = self
            composer.setToRecipients(["thodep@yahoo.com"])
            composer.navigationBar.tintColor = UIColor.whiteColor()
          
            
           // presentViewController(composer, animated: true, completion: nil)
            presentViewController(composer, animated: true, completion: {
                UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
              
                })
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
            switch result.rawValue {
    case MFMailComposeResultCancelled.rawValue:
        print("Mail cancelled")
    case MFMailComposeResultSaved.rawValue:
        print("Mail saved")
    case MFMailComposeResultSent.rawValue:
        print("Mail sent")
    case MFMailComposeResultFailed.rawValue:
        print("Failed to send mail: \(error!.localizedDescription)")
    default:
        break
            }
            // Dismiss the Mail interface
            dismissViewControllerAnimated(true, completion: nil)
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
