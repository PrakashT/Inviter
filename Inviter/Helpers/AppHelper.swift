//
//  AppHelper.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/26/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

enum CategoryType {
    case Generic
    case Specific
}

class AppHelper:NSObject {
    
    class var Instance: AppHelper
    {
        struct staticStruct
        {
            static let instance = AppHelper()
        }
        return staticStruct.instance;
    }
  
    func getJSONStringfromDictionary(_ dictionary: Dictionary<String, String>) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return String(data: jsonData!, encoding: .utf8)!
    }
    
    func ShowAlertView(title: String, message: String, selfVC: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        selfVC.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func getUserAuthParameters() -> Dictionary<String, String>
    {
        return ["Autherization": "Token "+UserDefaults.standard.value(forKey: "accessToken").debugDescription]
    }
    
    func appLogoColor() -> UIColor {
        return UIColor(red:0.82, green:0.15, blue:0.49, alpha:1)
    }
    
    func setDottedLineToView(yourView:UIView)
    {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,2]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: yourView.frame.width, y: 0)])
        path.addLines(between: [CGPoint(x: 0, y: yourView.frame.height),
                                CGPoint(x: yourView.frame.width, y: 0)])
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: 0, y: yourView.frame.height)])
        path.addLines(between: [CGPoint(x: yourView.frame.width, y: 0),
                                CGPoint(x: 0, y: yourView.frame.height)])
        shapeLayer.path = path
        yourView.layer.addSublayer(shapeLayer)
    }
}
