//
//  MyVideosViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/25/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

class MyVideosViewController: UIViewController, UITableViewDataSource
{
    @IBOutlet weak var myVideosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myVideosTableView.register(UINib.init(nibName: "MyVideosTableViewCell", bundle: nil), forCellReuseIdentifier: "MyVideosTableViewCellID")
    }
    
    // MARK: UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyVideosTableViewCellID", for: indexPath) as! MyVideosTableViewCell
        
        return cell
    }
}
