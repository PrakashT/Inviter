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
import GoogleSignIn
import MBProgressHUD

class CreateAccountViewController: UIViewController, GIDSignInUIDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextFiield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInFBButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.borderColor = UIColor(red:0.82, green:0.15, blue:0.49, alpha:1).cgColor
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2.0

//        let parameters = [
//            "emailID": "ravikant.software@gmail.com",
//            ]
//        NetworkManager.Instance.checkUserExistence(parameters) { (response) in
//
//        }

        if FBSDKAccessToken.currentAccessTokenIsActive()
        {
            // User is logged in, do work such as go to next view controller.
        }
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if AppHelper.Instance.isValidEmail(testStr: emailTextField.text!) && (passwordTextFiield.text?.count)! > 2 && (nameTextField.text?.count)! > 2
        {
            MBProgressHUD.showAdded(to: self.view, animated: true)

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
                
                MBProgressHUD.hide(for: self.view, animated: true)

                if response["description"].description == "User registration successfully done"
                {
                    EventsLogHelper.Instance.logRegistrationEvent(userId: response["data"]["userID"].description, emailId: self.emailTextField.text!, signUpMethod: "Login", country: "", city: "")

                    UserDefaults.standard.set(response["data"]["userID"].description, forKey: "userID")
                    UserDefaults.standard.set(self.emailTextField.text!, forKey: "emailID")

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
    
    @IBAction func loginWithGoogleButtonClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func loginWithFacebookButtonClicked(_ sender: Any) {
        if FBSDKAccessToken.current() != nil {
            FBSDKLoginManager().logOut()
            return
        }
        
        let loginManager = FBSDKLoginManager()
        //            loginManager.logIn(withPublishPermissions:["email", "public_profile"], from: self){ result, error in
        loginManager.logIn(withPublishPermissions: ["publish_actions"], from: self) { (result, error) in
            if(error != nil){
                FBSDKLoginManager().logOut()
            }else if(result?.isCancelled ?? false){
                FBSDKLoginManager().logOut()
            }else{
                //Handle login success
                print("success Get user information.")
                
                let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"email", "fields2":"public_profile"]);
                fbRequest?.start { (connection, result, error) -> Void in
                    
                    if error == nil {
                        print("User Info :", result)
                    } else {
                        
                        print("Error Getting Info \(error)");
                        
                    }
                }
            }
        }
    }
    
    // MARK:- UITextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == passwordTextFiield
        {
            textField.returnKeyType = .done
        }
        else
        {
            textField.returnKeyType = .next
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField
        {
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField
        {
            passwordTextFiield.becomeFirstResponder()
        }
        else
        {
            passwordTextFiield.resignFirstResponder()
        }
        return true
    }
}

