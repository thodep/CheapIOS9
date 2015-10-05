//
//  DetailViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-09-28.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBook

class DetailViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var detailRestaurantName: UILabel!
    
    @IBOutlet weak var detailRatingImage: UIImageView!
    
    @IBOutlet weak var detailRestType: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var detailRestAddressLabel: UILabel!
    
    @IBOutlet weak var detailDistance: UILabel!
    
    @IBOutlet weak var makephoneCall: UIButton!
    
    @IBOutlet weak var getDirectionButton: UIButton!
    
    @IBOutlet weak var reviewButton: UIButton!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var hoursOperation: UILabel!
  
    
    var locationManager = CLLocationManager()
    var resturant: Business?
    
    var coords: CLLocationCoordinate2D?
    var destination: MKMapItem?
    var region:MKCoordinateRegion?
    var userLocation:CLLocationCoordinate2D?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = self.resturant!.name
        // modify call button
        makephoneCall.layer.cornerRadius = 5
        makephoneCall.layer.masksToBounds = true
        makephoneCall.layer.borderColor = UIColor.grayColor().CGColor
        makephoneCall.layer.borderWidth = 0.5
        // modify get direction button
        getDirectionButton.layer.cornerRadius = 5
        getDirectionButton.layer.masksToBounds = true
        getDirectionButton.layer.borderColor = UIColor.grayColor().CGColor
        getDirectionButton.layer.borderWidth = 0.5
        // modify review button 
        reviewButton.layer.cornerRadius = 5
        reviewButton.layer.masksToBounds = true
        reviewButton.layer.borderColor = UIColor.grayColor().CGColor
        reviewButton.layer.borderWidth = 0.5
        // modify mapView
        mapView.layer.cornerRadius = 5
        mapView.layer.masksToBounds = true
        mapView.layer.borderColor = UIColor.grayColor().CGColor
        mapView.layer.borderWidth = 0.5
        
        //------- Pull data from tableview to display on detail view
        detailRestaurantName.text = resturant?.name
        detailRestType.text = resturant?.categories
        detailRestAddressLabel.text = resturant?.address
        detailDistance.text = resturant?.distance
        
        //------ rating image
        if let rating = resturant?.ratingImageURL {
        self.detailRatingImage.setImageWithURL( rating)
        }
        
        //------- working on open /close button . Logic here is not correct
        
                if (resturant?.openHours! == true ) {
                    
                    hoursOperation.text = "Open"
                    hoursOperation.textColor = UIColor.greenColor()
        
                }  else if (resturant?.openHours! == false) {
                    hoursOperation.text = "Closed"
                    hoursOperation.textColor = UIColor.redColor()
        }
        
        //--------Restaurant Phone Number
        if phoneNumber !== nil{
            phoneNumber.text = resturant?.phoneNumber1
          
        } else  {
         return  phoneNumber.text = nil
        }
        
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.showsUserLocation = true
            
        }
        
        let centre:CLLocationCoordinate2D = CLLocationCoordinate2DMake(43.64251, -79.387038)
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let regionToDisplay = MKCoordinateRegionMake(centre, span)
        self.mapView.setRegion(regionToDisplay, animated: true)

    }
    
    @IBAction func callForReservation(sender: AnyObject) {
    
        if phoneNumber == nil {
            print("there is no phone number")
        
        } else {
            // use stringByReplacingOccurrencesOfString / stringWithFormat to modify phone number
            // http://stackoverflow.com/questions/26759768/string-replace-phone-number-ios-swift

            if let phoneNum = resturant?.phoneNumber1 {
                phoneNumber.text = phoneNum
                
               
               
            if let url = NSURL(string: "tel://\(phoneNum)") {
                    UIApplication.sharedApplication().openURL(url)
                 print(phoneNum)
                }
            }
        }
    }
    
    
    @IBAction func getRestDirection(sender: AnyObject) {
        self.getDirections()
    
    
        }
    //-------------MapView Delegation Method -------------
    func getDirections(){
        let destinationCoords = CLLocationCoordinate2DMake(resturant!.coordinate.latitude,resturant!.coordinate.longitude)
        let placemark = MKPlacemark(coordinate: destinationCoords, addressDictionary: nil)
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = MKMapItem(placemark: placemark)
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { (response:MKDirectionsResponse?, error:NSError?) -> Void in
            if error != nil {
            print("error getting directions")
            } else {
            self.showRoute(response!)
            }
        }
        
        
    }
    func showRoute(response: MKDirectionsResponse) {
        for route in response.routes {
            mapView.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
            for step in route.steps {
                print(step.instructions)
            }
        }
        if let loc = mapView.userLocation.location {
            let region = MKCoordinateRegionMakeWithDistance(
                loc.coordinate, 2000, 2000)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay
        overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.orangeColor()
            renderer.lineWidth = 5.0
            return renderer
    }
    //--------------------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
            self.mapView.delegate = self
            let span = MKCoordinateSpanMake(0.01, 0.01)
        
            if let resturant = resturant {
            region = MKCoordinateRegion(center: resturant.coordinate, span: span)
            
            mapView.setRegion(region!, animated: true)
            mapView.layer.cornerRadius = 5
            mapView.layer.masksToBounds = true
            mapView.layer.borderColor = UIColor.grayColor().CGColor
            mapView.layer.borderWidth = 1.0
            
            // create annotation for each restaurant
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = resturant.coordinate
            annotation.title = resturant.name
            annotation.subtitle = resturant.address
            mapView.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
