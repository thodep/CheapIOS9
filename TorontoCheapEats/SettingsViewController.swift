//
//  SettingsViewController.swift
//  BuddyUp
//
//  Created by Yung Dai on 2015-10-13.
//  Copyright © 2015 Yung Dai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet var emailAddressTextField: UITextField!
    
    @IBOutlet var userImageView: PictureImageView!
   
    
    // image picker variables
    let imagePicker = UIImagePickerController()
    
    // user image
    // TODO impliment enum for the image
    enum UserImage {
        case FacebookImage
        case CustomImage
        case NoImage
    }
    

    @IBAction func logoutButtonPressed(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("goBacktoMain", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (result: PFObject?, error: NSError?) -> Void in
            if error != nil {
                // throws error
            }
            if let user = result {
                
                if let firstName = user["first_name"] as? String {
                    self.firstNameTextField.text = firstName
                }
                
                if let lastName = user["last_name"] as? String {
                    self.lastNameTextField.text = lastName
                }
                
                if let email = user["email"] as? String {
                    self.emailAddressTextField.text = email
                }
                
                
                // take and display the facebook image URL
                if let userPicture = user["photo"] as? String {
                    
                    // parse the photo URL into data for the UIImageView
                    self.userImageView.image = self.userImageView.downloadImage(userPicture)
                    
                    
                } else if let userPicture = user["userImage"] as? PFFile {
                    userPicture.getDataInBackgroundWithBlock({ (data, error: NSError?) -> Void in
                        if (error != nil) {
                            print(error)
                            // TODO throw error message
                            return
                        }
                        
                        if let newData = data {
                            self.userImageView.image = UIImage(data: newData)
                        }
                        
                    })
                }
                
            }
        })
        
         navigationItem.titleView = UIImageView(image: UIImage(named: "linecons_e026(0)_55"))
    }

    
    @IBAction func savePressed(sender: AnyObject) {
        resign()
        // REMEMBER TO WRAP YOUR VARIABLES IN IF LET's!!!!
        if let user = PFUser.currentUser() {
            user["first_name"] = firstNameTextField.text
            user["last_name"] = lastNameTextField.text
            let name = "\(firstNameTextField.text) \(lastNameTextField.text)"
            user["name"] = name
            user["email"] = emailAddressTextField.text
            
            // get the image file name
            user["userImage"] = PFFile(name:"image.jpg" , data: UIImageJPEGRepresentation(userImageView.image!, 0.5)!)
            
            user.saveInBackgroundWithBlock({ (sucess, error: NSError?) -> Void in
                if (error != nil) {
                    print(error)
                    
                } else {
                    // TODO: give response for saved data
                    print("saved")
                    
                    let uiAlert = UIAlertController(title: "Bye", message: "Thanks for using our app", preferredStyle: UIAlertControllerStyle.Alert)
                    self.presentViewController(uiAlert, animated: true, completion: nil)
                    
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                        print("Click of default button")
                        
                        // to go back to main App
                       self.performSegueWithIdentifier("goBacktoMain", sender: self)

                        
                        
                    }))
                    
                }
            })
            
        }
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let uiAlert = UIAlertController(title: "Bye", message: "Thanks for using our app", preferredStyle: UIAlertControllerStyle.Alert)
//        self.presentViewController(uiAlert, animated: true, completion: nil)
//        
//        uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
//            print("Click of default button")
//    
//            // to go back to main App
//             self.dismissViewControllerAnimated(true, completion: nil)
//            if (segue.identifier == "goBacktoMain") {
//                let businessVC = segue.destinationViewController as? BusinessViewController
//               
//                print("hey")
//            
//            }
//
//           
//        }))
//
//    }
    // choose from the library of photos
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        userImageView.contentMode = .ScaleAspectFill
        userImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func addPictureButtonPressed(sender: UIButton) {
        
        // pop up an action sheet
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        
        // select from photo library
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .Default) { (alert: UIAlertAction) -> Void in
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.imagePicker.allowsEditing = false
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        
        let camera = UIAlertAction(title: "Use Camera", style: .Default) { (alert: UIAlertAction) -> Void in
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.imagePicker.allowsEditing = false
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction) -> Void in
            print("Cancelled")
        })
        
        // make it work on an iPad
        optionMenu.popoverPresentationController?.sourceView = sender as UIView
        optionMenu.addAction(photoLibrary)
        optionMenu.addAction(camera)
        optionMenu.addAction(cancelAction)
        
        presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
    // resign they keyboard
    func resign() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailAddressTextField.resignFirstResponder()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
