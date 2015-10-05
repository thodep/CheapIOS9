//
//  BusinessController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-02.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit

class BusinessController: NSObject {
    var businesses: [Business] = []
    
    func searchForRestaurants(shouldReload:Bool = true, callBack:([Business]) -> Void) {
        Business.searchWithTerm("cheap_eats", sort: .BestMatched, categories: [""], deals: false, offset: self.businesses.count) {
            (results: [Business]!, error: NSError!) -> Void in
            if let rests = results {
                if shouldReload {
                    self.businesses = rests
                } else {
                    self.businesses.appendContentsOf(rests)
                }
                callBack(self.businesses)
            }
        }
    }
}
