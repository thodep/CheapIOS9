//
//  ReviewViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-06.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var bgroundView: UIView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var notCheapButton: UIButton!
    
    @IBOutlet weak var cheapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // modify the backgroundView 
        bgroundView.layer.cornerRadius = 10
        bgroundView.layer.masksToBounds = true
        // modify Not Cheap Button
        notCheapButton.layer.cornerRadius = 30
        notCheapButton.layer.masksToBounds = true
        // Modify Cheap Button
        cheapButton.layer.cornerRadius = 30
        cheapButton.layer.masksToBounds = true
        // Blur the background 
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.init(rawValue: 10)!)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
        

        
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
