//
//  YelpAPI.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-09-24.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import Foundation
//http://www.yelp.com/developers/manage_api_keys (API v2.0)

let yelpConsumerKey = "1tcROctuu-yJUrOl9_NtSg"
let yelpConsumerSecret = "vHASjU5Zk6_f6Ze6sUhBQ-ys8gs"
let yelpToken = "krWjyPWFwx1hB9z3sAGYGPz9fAItZYNV"
let yelpTokenSecret = "uYHP4W15vPN1b8HG8_xJ7j12wt8"

enum YelpSortMode: Int {
    case BestMatched = 0
    case Distance
    case HighestRated
}
//---------- Create a Class -----------
class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    class var sharedInstance : YelpClient {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : YelpClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return Static.instance!
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        // AFHTTPRequestOperationManager Super Class
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret)
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
       // return searchWithTerm(term, sort: nil, categories: nil, deals: nil, completion: completion)
        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, offset: Int(), completion: completion)
    }
    

    
    func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, offset:Int, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to Toronto
        var parameters: [String : AnyObject] = ["term": term, "ll": "43.6532,-79.3832", "offset": offset]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joinWithSeparator(",")
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals!
        }
        
        print(parameters)
        
        return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let dictionaries = response["businesses"] as? [NSDictionary]
            if dictionaries != nil {
                completion(Business.businesses(array: dictionaries!), nil)
            }
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                completion(nil, error)
        })
    }
    
    
}