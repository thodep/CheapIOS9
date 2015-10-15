//
//  Restaurant+CoreDataProperties.swift
//  
//
//  Created by tho dang on 2015-10-14.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurant {

    @NSManaged var restaurantAddress: String?
    @NSManaged var restaurantDistance: String?
    @NSManaged var restaurantImage: NSData?
    @NSManaged var restaurantLatitude: NSNumber?
    @NSManaged var restaurantLongtitude: NSNumber?
    @NSManaged var restaurantName: String?
    @NSManaged var restaurantOpenHours: NSNumber?
    @NSManaged var restaurantPhone: String?
    @NSManaged var restaurantRatingImage: NSData?
    @NSManaged var restaurantCategories: String?

}
