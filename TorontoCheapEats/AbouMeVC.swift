//
//  AbouMeVC.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-25.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit

class AbouMeVC: UIViewController {

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
