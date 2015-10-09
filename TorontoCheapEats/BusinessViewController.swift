//
//  BusinessViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-09-24.
//  Copyright © 2015 Tho Dang. All rights reserved.
//



// Suggestion :
// Binary Review : set it yes or no (cheap or not ), show the percentage of customer satisfaction , thumbs up and down icon

import UIKit

class BusinessViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchResultsUpdating , UISearchBarDelegate{
    var businesses: [Business]!
    var searchResults:[Business] = []
    var searchController: UISearchController!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginButton: UIBarButtonItem!
    
    let numberOfElements = 20
    var numberOfRestaurantsOffset:Int = 0 //the starting point for restaurants retrived in search starting zero

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureViewControllerForBusinessesAndInfiniteScrolling()
         self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:240.0/255.0, alpha: 0.2)
     
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
        // Yung Code
        
        if PFUser.currentUser()?.sessionToken != nil {
            loginButton.title = "Logout"
            
        } else {
            loginButton.title = "Login"
        }
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            print("User is already logged in go to the next viewcontroller")
            
        }
    }
    //----Adding Search Bar & implement Search Methods-------------
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        
        searchController.searchBar.barTintColor = UIColor(red: 231.0/255.0, green: 95.0/255.0, blue:
            53.0/255.0, alpha: 0.3)
        // Set cancel button in white
        searchController.searchBar.tintColor = UIColor.whiteColor()

        tableView.tableHeaderView = searchController.searchBar
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
    
    //---------------------
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
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BusinessTableViewCell
        if let rests = self.businesses{
            //let rest = rests[indexPath.row]
         let rest = (searchController.active) ? searchResults[indexPath.row] : rests[indexPath.row]
            cell.nameLabel.text = rest.name
            cell.addressLabel.text = rest.address
            cell.typeLabel.text = rest.categories
            
            cell.restaurantImage.setImageWithURL(rest.imageURL)
            cell.ratingImage.setImageWithURL(rest.ratingImageURL)
            cell.distanceLabel.text = rest.distance
            cell.restaurantImage.layer.cornerRadius = 10
            cell.restaurantImage.layer.masksToBounds = true
            cell.backgroundColor = UIColor.clearColor()
            
        }
        
    return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetail"){
        let detailView = segue.destinationViewController as? DetailViewController
            let selectedRow = self.tableView.indexPathForSelectedRow!.row
            if let biz = self.businesses {
                //detailView?.resturant = biz[selectedRow]
               detailView?.resturant = (searchController.active) ? searchResults[selectedRow] :
                biz[selectedRow]
            }
        }
       
    }
    
    
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
    
    // Yung Code
    @IBAction func loginButtonPressed(sender: AnyObject) {
        

        if loginButton.title == "Login" {
            let loginVC : UIViewController = (storyboard?.instantiateViewControllerWithIdentifier("Login"))!
            self.presentViewController(loginVC, animated: true, completion: nil)
        } else if loginButton.title == "Logout" {
            processSignOut()
            loginButton.title = "Login"
        }
        
        
    }

    
    // Sign the current user out of the app
    func processSignOut() {
        
        // // Sign out
        PFUser.logOut()
        print("User logged out")
    }
}


