//
//  ReviewViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-06.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var badRating: ButtonStyle!
    
    @IBOutlet weak var goodRating: ButtonStyle!
    
    @IBOutlet weak var closeButton: ButtonStyle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func happButtonPressed(sender: AnyObject) {
    }
    
    
    @IBAction func unHappyButtonPressed(sender: AnyObject) {
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
