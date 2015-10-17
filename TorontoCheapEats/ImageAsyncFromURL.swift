//
//  UIImageAsynch.swift
//  
//
//  Created by Yung Dai on 2015-06-23.
//
//
import Foundation
import UIKit


// extension for UIImageView for Asyncrhonously downloading a URL of a picture into a UIImageView
/* Usage 
    downloading: UIImageView.downloadImage("http://www.image-server.com/myImage.jpg")
*/
extension UIImageView {
    
    func getDataFromUrl(url:String, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
            completion(data: NSData(data: data!))
            }.resume()
    }
    
    func downloadImage(url:String) -> UIImage {
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode = UIViewContentMode.ScaleAspectFill
                self.image = UIImage(data: data!)
            }
            
        }
        return self.image!
    }

}
