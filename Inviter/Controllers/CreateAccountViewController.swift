//
//  CreateAccountViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/24/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation
import FBSDKLoginKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var passwordTextFiield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInFBButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.borderColor = UIColor(red:0.82, green:0.15, blue:0.49, alpha:1).cgColor
        
        let parameters = [
            "emailID": "ravikant.software@gmail.com",
            ]
        NetworkManager.Instance.checkUserExistence(parameters) { (response) in
        }
        
//        let parameters2 = [
//            "userData": "{\"appType\":\"1\",\"authenticationType\":\"1\",\"timeZone\":\"-05:00_EST\",\"name\":\"1\",\"emailID\":\"rajesh1010@gmail.com\",\"password\":\"ddddd\"}",
//            ]
        
        if FBSDKAccessToken.currentAccessTokenIsActive()
        {
            // User is logged in, do work such as go to next view controller.
        }
        logInFBButton.readPermissions = ["public_profile", "email"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }
   
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if AppHelper.Instance.isValidEmail(testStr: emailTextField.text!) && (passwordTextFiield.text?.count)! > 2 && (nameTextField.text?.count)! > 2
        {
            let parametersDic = [
                "appType": "1",
                "authenticationType": "1",
                "timeZone": "-05:00_EST",
                "name": nameTextField.text!,
                "emailID": emailTextField.text!,
                "password": passwordTextFiield.text!,
                ]
            let parameters = ["userData":AppHelper.Instance.getJSONStringfromDictionary(parametersDic)]
            
            NetworkManager.Instance.createNewUser(parameters) { (response) in
                print("RESTTTTTT: "+response["description"].description)
                
                if response["description"].description == "User registration successfully done"
                {
                    UserDefaults.standard.set(response["data"]["userID"].description, forKey: "userID")
                    UserDefaults.standard.synchronize()
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarControllerID")
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
