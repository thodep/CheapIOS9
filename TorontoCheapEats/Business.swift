//
//  Business.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-09-24.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

    
import UIKit
import CoreLocation
import MapKit

class Business: NSObject , MKAnnotation{
    let name: String?
    let address: String?
    let imageURL: NSURL?
    let categories: String?
    let distance: String?
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    let phoneNumber1: String?
    var openHours : Bool?
    
    let businessLocation: CLLocation?
    
    var title: String? {
        return name
    }
    var subtitle: String? {
    return address
    }
    
    var latitude: Double {
        return (businessLocation?.coordinate.latitude)!
    }
    var longitude: Double {
        return (businessLocation?.coordinate.longitude)!
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(dictionary: NSDictionary) {
        //---------- restaurant name API
        name = dictionary["name"] as? String

        //----------restaurant Phone Number
         let  phone = dictionary["display_phone"] as? String
        if phone != nil {
         phoneNumber1 = phone!
        } else {
        phoneNumber1 = nil
            
        }
         //---------- Restaurant Hours Operation API
        if let  isClosed = dictionary["is_closed"] as? Bool {
        openHours = !isClosed
        } else {
        openHours = false
        }
        //----------- restaurant image API
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = NSURL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        //----------- restaurant address API
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
           
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        //------------ restaurant category API
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joinWithSeparator(", ")
        } else {
            categories = nil
        }
        //-------------- distance API
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        //------------ restaurant rating API
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = NSURL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        //------------ review count API
        reviewCount = dictionary["review_count"] as? NSNumber
        
        //------------ Store Longtitude & Latitude & Coordinate-----------------------
        
            var tempBusinessLocation: CLLocation? = nil
        if let coordinateDict = location!["coordinate"] as? NSDictionary {
            let lat = coordinateDict["latitude"] as! CLLocationDegrees
            let long = coordinateDict["longitude"] as! CLLocationDegrees
            tempBusinessLocation = CLLocation(latitude: lat, longitude: long)
        }
            self.businessLocation = tempBusinessLocation

       // ---------------------------------------------------------------
    }
    
    class func businesses(array array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
   
    class func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) {
        YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }

    
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, offset:Int, completion: ([Business]!, NSError!) -> Void) -> Void {
        YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, offset: offset, completion: completion)
    }
    
}