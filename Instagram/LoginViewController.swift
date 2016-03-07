//
//  LoginViewController.swift
//  Instagram
//
//  Created by Lily Tran on 3/1/16.
//  Copyright © 2016 Lily Tran. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func  preferredStatusBarStyle()-> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func signIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else {
                self.showAlertMessage("Login Error", messages: "\(error?.localizedDescription)")
                print("\(error?.localizedDescription)")
            }
        }
    }

    @IBAction func signUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text!
        newUser.password = passwordField.text!
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Created new user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                if error?.code == 202 {
                    self.showAlertMessage("Sign Up Error", messages: "Username taken")
                    print("Username taken")
                }
                else {
                    self.showAlertMessage("Sign Up Error", messages: "\(error?.localizedDescription)")
                    print("\(error?.localizedDescription) error code: \(error?.code)")
                }
            }
        }
    }
    
    //Show error message
    func showAlertMessage(titles: String, messages: String) {
        let alertController = UIAlertController(title: "\(titles)", message: "\(messages)", preferredStyle: .Alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
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
