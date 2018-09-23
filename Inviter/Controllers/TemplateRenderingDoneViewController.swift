//
//  TemplateRenderingDoneViewController.swift
//  Inviter
//
//  Created by People Tech on 29/08/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import Foundation
import UIKit

class TemplateRenderingDoneViewController: UIViewController
{
    @IBOutlet weak var musicListTableView: UITableView!
    @IBOutlet weak var notifyMeButton: UIButton!
    @IBOutlet weak var continueBrowsingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueBrosingButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notifyMeButtonClicked(_ sender: UIButton) {
        sender.isHidden = true
    }
}

