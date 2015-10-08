//
//  LogInViewController.swift
//  TorontoCheapEats
//
//  Created by tho dang on 2015-10-06.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    // keyboard movement upwards value
    var kbHeight: CGFloat!
    var keyboardWasShown = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        usernameField!.delegate = self
//        passwordField!.delegate = self
        
        if PFUser.currentUser()?.sessionToken != nil {
            print("sending user to the main app screen because he's a current user")
            
            self.performSegueWithIdentifier("pushToMainPage", sender: self)
        } else {
            // Show the signup or login screen
            return
        }
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            print("User is already logged in go to the next viewcontroller")
            
        }
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if keyboardWasShown {
            return
        } else {
            if let userInfo = notification.userInfo {
                if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                    kbHeight = 60.0
                    animateTextField(true)
                    keyboardWasShown = true
                    
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        animateTextField(false)
        
        // reset the state of the keyboard
        keyboardWasShown = false
    }
    
    
    func animateTextField(up: Bool) {
        let movement = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    
    // if you press the return button the keyboard will dissappear
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resign()
        return true
    }
    
    // resigning all first responders
    func resign() {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        resign()
        
    }
    
    let permissions = ["public_profile", "email", "user_friends"]
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        processFieldEntries()
        
    }
    
    func processFieldEntries() {
        let username = usernameField.text
        let password = passwordField.text
        let noUsernameText = " username"
        let noPasswordText = " password"
        var errorText = "No"
        let errorTextJoin = " or "
        let errorTextEnding = " entered"
        var textError:Bool = false
        
        // Messaging nil will return 0, so these checks impicity check for nil text.
        
        if username!.characters.count == 0 || password!.characters.count == 0 {
            textError = true
            
            // set up the keyboard for the first field missing input
            if password!.characters.count == 0 {
                passwordField.becomeFirstResponder()
            }
            
            if username!.characters.count == 0 {
                usernameField.becomeFirstResponder()
            }
        }
        
        // if the username entered text box lenth is 0
        if username!.characters.count == 0 {
            textError = true
            errorText += noUsernameText
        }
        
        if password!.characters.count == 0 {
            textError = true
            if username!.characters.count == 0 {
                errorText += errorTextJoin
            }
            errorText += noPasswordText
        }
        
        
        // present a popup to alert that there was an error
        if textError {
            errorText += errorTextEnding
            errorMessage.text = errorText
            let alert = UIAlertController(title: "Alert", message: errorText, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // log in the user with Parse
        PFUser.logInWithUsernameInBackground(username!, password: password!) {
            (user: PFUser?, error: NSError?) -> Void in
            
            // check for email verification
            if user!["emailVerified"] as! Bool == true {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier(
                        "mainApp",
                        sender: self
                    )
                    // save the user's location to parse before you save the information
                    PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint:PFGeoPoint?, error:NSError?) -> Void in
                        if let user = PFUser.currentUser() {
                            user["currentLocation"] = geoPoint
                            user.saveInBackground()
                        }
                        print("user is logged in and location is updated")
                    }
                    self.performSegueWithIdentifier("pushToMainPage", sender: nil)
                }
            } else {
                // User needs to verify email address before continuing
                let alertController = UIAlertController(
                    title: "Email address verification",
                    message: "We have sent you an email that contains a link - you must click this link before you can continue.",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alertController.addAction(UIAlertAction(title: "OKAY",
                    style: UIAlertActionStyle.Default,
                    handler: { alertController in self.processSignOut()})
                )
                // Display alert
                self.presentViewController(
                    alertController,
                    animated: true,
                    completion: nil
                )
            }
            
            // check for error messages
            if error != nil {
                // save the user's location to parse before you save the information
                PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint:PFGeoPoint?, error:NSError?) -> Void in
                    if let user = PFUser.currentUser() {
                        user["currentLocation"] = geoPoint
                        user.saveInBackground()
                    }
                    print("user is logged in and location is updated")
                }
                self.performSegueWithIdentifier("pushToMainPage", sender: nil)
                
            } else {
                print("log in failed")
                self.errorMessage.text = "Log in failed"
                return
            }
        }
    }
    
    // Sign the current user out of the app
    func processSignOut() {
        
        // // Sign out
        PFUser.logOut()
        
        // Display sign in / up view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("Login")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    
    @IBAction func signupButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func facebookButton
        (sender: AnyObject) {
            self.errorMessage.alpha = 0
            PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions as [AnyObject]) {
                (user: PFUser?, error: NSError?) -> Void in
                
                if error != nil
                {
                    return
                }
                if let parseUser = user {
                    if parseUser.isNew {
                        print("User signed up and logged in through Facebook!")
                        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me?fields=first_name,friends,gender,email,name,picture.width(300).height(300)", parameters: nil)
                        graphRequest.startWithCompletionHandler({
                            (connection, result, error) -> Void in
                            if (error != nil)
                            {
                                // display the error message
                                print("Error: \(error)")
                            } else {
                                // parsing the facebook data from the graph API and saving it to parse
                                // save the facebook name and email data to parseUser
                                parseUser["name"] = result["name"]
                                parseUser["email"] = result["email"]
                                parseUser["first_name"] = result["first_name"]
                                parseUser["gender"] = result["gender"]
                                
                                
                                // sending the facebook picture to parse as a string and saving the user image to parse userImage field
                                if let pictureResult = result["picture"] as? NSDictionary,
                                    pictureData = pictureResult["data"] as? NSDictionary,
                                    picture = pictureData["url"] as? String {
                                        parseUser["photo"] = picture
                                        
                                }
                                
                                
                                
                                
                                // save the user's location to parse before you save the information
                                PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint:PFGeoPoint?, error:NSError?) -> Void in
                                    if let user = PFUser.currentUser() {
                                        user["currentLocation"] = geoPoint
                                        user.saveInBackground()
                                    }
                                }
                                parseUser.saveInBackground()
                                print("Parse User Saved")
                                self.performSegueWithIdentifier("pushToMainPage", sender: nil)
                            }
                        })
                    } else {
                        print("You are already a user, I'll just send you the main page")
                        
                        // save the user's location to parse before you save the information
                        PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint:PFGeoPoint?, error:NSError?) -> Void in
                            if let user = PFUser.currentUser() {
                                user["currentLocation"] = geoPoint
                                print("Saving User's Location In Background")
                                user.saveInBackground()
                            }
                            
                        }
                        self.performSegueWithIdentifier("pushToMainPage", sender: nil)
                    }
                }
            }
    }
}
