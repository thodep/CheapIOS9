//
//  BusinessViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-09-24.
//  Copyright © 2015 Tho Dang. All rights reserved.
//


import UIKit
import CoreData

class BusinessViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchResultsUpdating , UISearchBarDelegate{
    
    var businesses: [Business]!
    var searchResults:[Business] = []
    var searchController: UISearchController!
    
    @IBOutlet weak var tableView: UITableView!
    
  //  var restaurantsFromCD = [Restaurant]()
    
    
    // Working With Coredata
//    func saveRestaurant(restaurant: Business){
//    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let context = delegate.managedObjectContext
//
//    let restaurantCD = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: context) as! Restaurant
//        
//        restaurantCD.setValue(restaurant.name, forKey: "restaurantName")
//        restaurantCD.setValue(restaurant.address, forKey: "restaurantAddress")
//        restaurantCD.setValue(restaurant.distance, forKey: "restaurantDistance")
//        restaurantCD.setValue(restaurant.categories, forKey: "restaurantCategories")
//        
//        // Convert NSURL to NSData???
//        // http://stackoverflow.com/questions/22951791/click-to-add-image-to-core-data
//       // restaurantCD.setValue(restaurant.imageURL, forKey: "restaurantImage")
//        
//        // add info to the Entity
//        var err: NSError?
//        do {
//        try context.save()
//            self.restaurantsFromCD.append(restaurantCD)
//        } catch let err1 as NSError {
//        err = err1
//        }
//        if err != nil {
//        print("There was an error saving data into coredata")
//        }
//    
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---- Working with CoreData-------
   
        // Reference to Manage Context to retrieve data from CoreData
//        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context = delegate.managedObjectContext
//        let request = NSFetchRequest(entityName: "Restaurant")
//        
//        
//        print(request)
//
//        var err : NSError?
//        do {
//        restaurantsFromCD = try context.executeFetchRequest(request) as! [Restaurant]
//        } catch let err1  as NSError {
//        err = err1
//        
//        }
//        if err != nil{
//        print("problem with coredata")
//        }
//     
      
        //---- End working with CoreData------
        
        configureSearchController()
        configureViewControllerForBusinessesAndInfiniteScrolling()
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:240.0/255.0, alpha: 0.2)
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
           
    }
    //----Adding Search Bar & implement Search Methods-------------

    
    func configureSearchController() {
        //  instanciate our searchController (it will display the result
        searchController = UISearchController(searchResultsController: nil)
        // Self is responsible for updating the contents of the search results controller
        searchController.searchResultsUpdater = self
        // Dim the current view when you sélect search bar ( will be hidden when the user type something)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        // Prevent the searchbar to disapear during search
       searchController.hidesNavigationBarDuringPresentation =   false
        searchController.searchBar.barTintColor = UIColor(red: 231.0/255.0, green: 95.0/255.0, blue:
            53.0/255.0, alpha: 0.3)
        // Set cancel button and search cursor in gray
        searchController.searchBar.tintColor = UIColor.blackColor()
         // Include the search controller's search bar on Navigation Bar
        navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
    

    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText!)
        tableView.reloadData()
        
    }
    func filterContentForSearchText(searchText: String) {
        searchResults = businesses.filter({ ( business: Business) -> Bool in
            265
            let nameMatch = business.name!.rangeOfString(searchText, options:
                NSStringCompareOptions.CaseInsensitiveSearch)
            let categoriesMatch = business.categories!.rangeOfString(searchText, options:
                NSStringCompareOptions.CaseInsensitiveSearch)
            // User now can search restaurant name and categories
            return nameMatch != nil || categoriesMatch != nil
        })
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }

    //--------------------- end working with Search Bar ------------------------
    
    func configureViewControllerForBusinessesAndInfiniteScrolling () {
        searchForRestaurants(true)
        tableView.addInfiniteScrollingWithActionHandler { () -> Void in
            self.tableView.infiniteScrollingView.stopAnimating()
            self.searchForRestaurants(false)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active {
            return searchResults.count
        } else  if let biz = self.businesses {
            return biz.count
        }
        return 0
    }

    // Display API data on tableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BusinessTableViewCell
        if let rests = self.businesses{
            //let rest = rests[indexPath.row]
            let rest = (searchController.active) ? searchResults[indexPath.row] : rests[indexPath.row]
            
            // Call CoreData Global Function
            //saveRestaurant(rest)

//            cell.nameLabel.text = restaurantsFromCD[indexPath.row].restaurantName
//            cell.addressLabel.text = restaurantsFromCD[indexPath.row].restaurantAddress
//            cell.distanceLabel.text = restaurantsFromCD[indexPath.row].restaurantDistance
//            cell.typeLabel.text = restaurantsFromCD[indexPath.row].restaurantCategories
            
            // http://stackoverflow.com/questions/14133366/convert-uiimage-to-nsdata-and-save-with-core-data
            
      
            cell.nameLabel.text = rest.name
            cell.addressLabel.text = rest.address
            cell.typeLabel.text = rest.categories
            cell.distanceLabel.text = rest.distance
            
            cell.restaurantImage.setImageWithURL(rest.imageURL)
            cell.ratingImage.setImageWithURL(rest.ratingImageURL)
           
            cell.restaurantImage.layer.cornerRadius = 10
            cell.restaurantImage.layer.masksToBounds = true
            cell.backgroundColor = UIColor.clearColor()
            
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetail"){
            
            //  that instanciate the detail VC as a destination VC
            let detailView = segue.destinationViewController as? DetailViewController
            // then get selected row from table view
            let selectedRow = self.tableView.indexPathForSelectedRow!.row
            
            if let biz = self.businesses {
                
                //detailView?.resturant = biz[selectedRow]
                detailView?.resturant = (searchController.active) ? searchResults[selectedRow] :
                    biz[selectedRow]
            }
        }
        
    }
    // Search for restaurants
    func searchForRestaurants(shouldReload:Bool = true) {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        appDelegate.businessController.searchForRestaurants(shouldReload) { (businesses) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}


