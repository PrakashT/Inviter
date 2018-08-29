//
//  ChooseMusicViewController.swift
//  Inviter
//
//  Created by People Tech on 29/08/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//
import UIKit
import Foundation

class ChooseMusicViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var musicListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicListTableView.register(UINib.init(nibName: "ChooseMusicTableViewCell", bundle: nil), forCellReuseIdentifier: "ChooseMusicTableViewCellID")
        
//        musicListTableView.estimatedRowHeight = 1.0
//        musicListTableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    // MARK: - UITableView DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseMusicTableViewCellID", for: indexPath) as! ChooseMusicTableViewCell
        
        return cell
    }
    
    
    
}
