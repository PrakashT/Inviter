//
//  LoginViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/24/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//
import UIKit
import Foundation
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logInFBButton: FBSDKLoginButton!
    @IBOutlet weak var passwordTextFiield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.borderColor = UIColor(red:0.82, green:0.15, blue:0.49, alpha:1).cgColor
        emailTextField.text = "manikanta.pt@gmail.com"
        passwordTextFiield.text = "mani123"
        
        if FBSDKAccessToken.currentAccessTokenIsActive()
        {
            // User is logged in, do work such as go to next view controller.
        }
        
        // Extend the code sample from 6a. Add Facebook Login to Your Code
        // Add to your viewDidLoad method:
        logInFBButton.readPermissions = ["public_profile", "email"]
        
        var loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["publish_actions"], from: self) { (result, error) in
            if result!.declinedPermissions.contains("publish_actions")
            {
                
            }
            else
            {
                
            }
        }
//        [loginManager logInWithPublishPermissions:@[@"publish_actions"]
//        fromViewController:self
//        handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//        if ([result.declinedPermissions containsObject:@”publish_actions”]) {
//        // TODO: do not request permissions again immediately. Consider providing a NUX
//        // describing  why the app want this permission.
//        } else {
//        // ...
//        }
//        }];
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func logInButtonClicked(_ sender: Any) {
        
        if AppHelper.Instance.isValidEmail(testStr: emailTextField.text!) && (passwordTextFiield.text?.count)! > 2
        {
            let parameters = [
                "emailID": emailTextField.text!,
                "password": passwordTextFiield.text!,
                ]
            
            NetworkManager.Instance.userLogin(parameters) { (response) in
                print("RESTTTTTT: "+response["description"].description)
                
                if response["description"].description == "User sign in successfully done"
                {
                    UserDefaults.standard.set(response["data"]["userID"].description, forKey: "userID")
                    UserDefaults.standard.set(response["data"]["emailID"].description, forKey: "emailID")

                    UserDefaults.standard.synchronize()
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationViewControllerID")
                    self.present(vc!, animated: true, completion: {})
                }
                else
                {
                    AppHelper.Instance.ShowAlertView(title: "Alert", message: response["description"].description, selfVC: self)
                }
            }
        }
        else
        {
            AppHelper.Instance.ShowAlertView(title: "Alert", message: "Please enter a valid credentials", selfVC: self)
        }
    }
    
    @IBAction func tapGestureRecognizerHandle(_ sender: Any) {
        self.view.endEditing(true)
    }
}
