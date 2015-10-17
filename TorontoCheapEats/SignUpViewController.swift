//
//  SignUpViewController.swift
//  BuddyUp
//
//  Created by Yung Dai on 2015-06-05.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!

    let reviewVC = ReviewViewController()
    
    var activityIndicator = UIActivityIndicatorView()
    
    // keyboard movement upwards value
   
    var kbHeight: CGFloat! = 60.0
   var keyboardWasShown = false

    @IBOutlet weak var errorMessageLabel: UILabel!

    @IBAction func createAccountButtonPressed(sender: UIButton) {
        processFieldEntries()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidden = true
        
        usernameField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        passwordField.delegate = self
        passwordConfirmationField.delegate = self
        emailAddressField.delegate = self
        
        

        navigationItem.titleView = UIImageView(image: UIImage(named: "linecons_e026(0)_55"))
    }
    
    // keyboard pushing code
    
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
                if let _ =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                    kbHeight = 60.0
                    animateTextField(true)
                    keyboardWasShown = true
                    
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    
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

    
    // resigning of firstResponders of the textField's
    func resign() {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        passwordConfirmationField.resignFirstResponder()
        emailAddressField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        firstNameField.resignFirstResponder()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        resign()

    }
    
    
    func processFieldEntries() {
        // setup the fields for the sign up page
        let username = usernameField.text
        let firstName = firstNameField.text
        let lastName = lastNameField.text
        let password = passwordField.text
        let passwordConfirmation = passwordConfirmationField.text
        let emailAddress = emailAddressField.text!.lowercaseString
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        
        var errorText = "Please "
        let usernameBlankText = "Enter a username."
        let firstNameBlankText = "Enter a first name."
        let lastNameBlankText = "Enter a last name."
        let passwordBlankText = "Enter a password."
        let emailBlankText = "Enter an email address."
        let jointText = ", and "
        let passwordMismatchText = "Enter the same password twice."
        
        var textError = false
        
        
        // Messaging nil will return 0, so these checks implicitly check for nil text.
        if username!.characters.count == 0 || password!.characters.count == 0 || passwordConfirmation!.characters.count == 0 {
            textError = true
            
            // Set up the keyboard for the first field missing input:
            if username!.characters.count == 0 {
                errorText += usernameBlankText
                usernameField.becomeFirstResponder()
            }
            
            if firstName!.characters.count == 0 {
                errorText += firstNameBlankText
                firstNameField.becomeFirstResponder()
            }
            
            if lastName!.characters.count == 0 {
                errorText += lastNameBlankText
                lastNameField.becomeFirstResponder()
            }
            
            
            if password!.characters.count == 0 {
                passwordField.becomeFirstResponder()
            }
            
            if passwordConfirmation!.characters.count == 0 {
                passwordConfirmationField.becomeFirstResponder()
            }
            
            if emailAddress.characters.count == 0 {
                errorText += emailBlankText
                emailAddressField.becomeFirstResponder()
            }
            
            // error text feedback for the password boxes
           if password!.characters.count == 0 || passwordConfirmation!.characters.count == 0 {
                if username!.characters.count == 0 {
                    // we need some joining text in the error
                    errorText += jointText
                }
                errorText += passwordBlankText
            }
            

            
        } else if password != passwordConfirmation {
            textError = true
            errorText += passwordMismatchText
            passwordField.becomeFirstResponder()
        }
        
        // present a popup if there was an error
        if textError {
            let alert = UIAlertController(title: "Alert", message: errorText, preferredStyle: UIAlertControllerStyle.Alert)
            
            self.presentViewController(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                print("Click of default button")
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
                print("Click of cancel button")
            }))

            
            return
        }

        
        // if those conditions clear you will create a new user and log in
        let parseUser = PFUser()
        parseUser.username = usernameField.text
        parseUser["first_name"] = firstNameField.text
        parseUser["last_name"] = lastNameField.text
        parseUser.password = passwordField.text
        parseUser["name"] = "\(firstNameField.text) \(lastNameField.text)"
        parseUser["email"] = emailAddressField.text
        parseUser.signUpInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) -> Void in
            
            if error == nil {
                print("signed up user to Parse")
              
                
                let uiAlert = UIAlertController(title: "Email address verification", message: "We have sent you an email that contains a link - you must click this link before you can continue.", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(uiAlert, animated: true, completion: nil)
                
                uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
                    //action in
                    
                    uiAlert in self.processSignOut()
                    
                    print("Click of default button")
                    print("Saved on Parse")
                    
                    // When user done w/ sign up , view should return to ReviewVC so she can do her review
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                  
                }))
               
              
                //------end
            } else {
                
                self.activityIndicator.stopAnimating()
                
                if let message: AnyObject = error!.userInfo["error"] {
                    self.errorMessageLabel.text = "\(message)"
                }
                return
            }
        })
    }
    
 
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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
}

