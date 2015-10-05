//
//  BusinessTableViewCell.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-09-25.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
