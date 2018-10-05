//
//  SettingsViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 10/4/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var settingsTableView: UITableView!
    
    @IBOutlet weak var versionLbl: UILabel!
    var appInfoList:[String: String] = ["About Us":APIConstants.ABOUT_US_LINK, "Terms of Service":APIConstants.TERMS_AND_SERVICES_LINK, "Privacy Policy":APIConstants.PRIVACY_POLICY_LINK]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.register(UINib.init(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCellID")
        
        // Do any additional setup after loading the view.
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let appBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        versionLbl.text = "Version " + appBuildVersion
    }
    
    // MARK: - UITableViewDataSources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : appInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCellID", for: indexPath) as! SettingsTableViewCell
        if indexPath.section == 0
        {
            cell.InfoLbl.text = UserDefaults.standard.value(forKey: "UserName") as? String
            cell.editButton.isHidden = false
            cell.separatorLineView.isHidden = false
        }
        else
        {
            cell.InfoLbl.text = Array(appInfoList.keys)[indexPath.row]
            cell.editButton.isHidden = true
            
            cell.separatorLineView.isHidden = !(indexPath.row == appInfoList.count-1)
        }
        
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let hView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let label = UILabel(frame: CGRect(x: 10, y: 20, width: hView.frame.width, height: 60-10-10))
        label.text = (section == 0) ? "Profile" : "App"
        label.textColor = UIColor.lightGray
        label.font = UIFont.init(name: "Arial Rounded MT Bold", size: 17)
        hView.addSubview(label)
        return hView
    }
    
    // MARK: - UITableViewDelegates
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1
        {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "WebViewControllerID") as! WebViewController
            vc.webURL = Array(appInfoList.values)[indexPath.row]
            vc.webViewTitle = Array(appInfoList.keys)[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func logOutButtonClicked(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.synchronize()
        
        self.tabBarController?.dismiss(animated: true, completion: {
            
        })
    }
}
