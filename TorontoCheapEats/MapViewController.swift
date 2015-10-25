//
//  MapViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-02.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,  CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var restaurantMapView: MKMapView!
    let locationManager = CLLocationManager()
    let detailVC = DetailViewController()
    var restaurantList:Business?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
     
        restaurantMapView.addAnnotations(appDelegate.businessController.businesses)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapSetUp()
        // Empty Back Button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
           navigationItem.titleView = UIImageView(image: UIImage(named: "linecons_e026(0)_55"))
    }
    
    func mapSetUp(){
    locationManager.startUpdatingLocation()
    locationManager.requestWhenInUseAuthorization()
    let status = CLLocationManager.authorizationStatus()
    if status == CLAuthorizationStatus.AuthorizedWhenInUse {
    restaurantMapView.showsUserLocation = true
        }
    let centre: CLLocationCoordinate2D = CLLocationCoordinate2DMake(43.6466,-79.3864)
    let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
    let regionToDisplay = MKCoordinateRegionMake(centre, span)
    restaurantMapView.setRegion(regionToDisplay, animated: true)
    }
    // ------------MapView Delegate Method-------------

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
       
         let identifier = "Business"
        if annotation.isKindOfClass(Business.self){
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation:annotation,reuseIdentifier:identifier)
        annotationView!.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            // left call out
            annotationView?.leftCalloutAccessoryView = nil
            annotationView?.rightCalloutAccessoryView = nil
            if let business = annotation as? Business {
                if business.imageURL != nil {
            
                    annotationView?.leftCalloutAccessoryView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
                }
                annotationView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
                
            }
            return annotationView
            }
         return nil
        }

    //-----------------set image into annotation-----
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let business = view.annotation as? Business, let thumbnailImageView = view.leftCalloutAccessoryView as? UIImageView {
            thumbnailImageView.contentMode = .ScaleAspectFit
            thumbnailImageView.setImageWithURL(business.imageURL)
            restaurantList = business
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
        if segue.identifier == "MapViewPushtoDetailView" {
            let dtVC = segue.destinationViewController as? DetailViewController
            dtVC?.resturant = restaurantList
            
        }
    }
    //----------click on annotation to go to Detail VC
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        performSegueWithIdentifier("MapViewPushtoDetailView", sender: self)
       
    }

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
