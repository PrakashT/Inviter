//
//  TemplateEditViewController.swift
//  Inviter
//
//  Created by People Tech on 29/08/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

class TemplateEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var templateTableView: UITableView!
    
    let sectionHeaderTitlesList: [String] = ["", "Music", "Title", "Content"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        templateTableView.register(UINib.init(nibName: "TemplateAddImageTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateAddImageTableViewCellID")
        
        templateTableView.register(UINib.init(nibName: "TemplateEditMusicTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateEditMusicTableViewCellID")
        
        templateTableView.register(UINib.init(nibName: "TemplateTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateTextFieldTableViewCellID")
       
        templateTableView.register(UINib.init(nibName: "TemplateEditButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateEditButtonsTableViewCellID")

        templateTableView.rowHeight = UITableViewAutomaticDimension
        templateTableView.estimatedRowHeight = 50.0
        templateTableView.needsUpdateConstraints()
    }
    
    // MARK: UITableView DataSources
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitlesList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateAddImageTableViewCellID", for: indexPath) as! TemplateAddImageTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateEditMusicTableViewCellID", for: indexPath) as! TemplateEditMusicTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateEditButtonsTableViewCellID", for: indexPath) as! TemplateEditButtonsTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateTextFieldTableViewCellID", for: indexPath) as! TemplateTextFieldTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitlesList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
