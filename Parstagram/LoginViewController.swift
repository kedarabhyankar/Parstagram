//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Kedar Abhyankar on 4/16/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameInput.text!
        let password = passwordInput.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if(user != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("Success! We logged you in.")
            } else {
                print("Error : \(error?.localizedDescription ?? "Some Undefined Error!")")
            }
        }
        
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser();
        user.username = usernameInput.text;
        user.password = passwordInput.text;
        user.signUpInBackground{(success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("Success! We signed you up.")
            } else {
                print("Error : \(error?.localizedDescription ?? "Some Undefined Error!")")
            }
        }
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
