//
//  LetsGoViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/26/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

class LetsGoViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.borderColor = UIColor(red:0.82, green:0.15, blue:0.49, alpha:1).cgColor
    }
    
}
