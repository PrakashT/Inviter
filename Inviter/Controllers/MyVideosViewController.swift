//
//  MyVideosViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/25/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

class MyVideosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyVideosTableViewCellDelegate
{
    
    @IBOutlet weak var myVideosTableView: UITableView!
    private var TemplatesList = [Template]()

    override func viewDidLoad() {
        super.viewDidLoad()
        myVideosTableView.register(UINib.init(nibName: "MyVideosTableViewCell", bundle: nil), forCellReuseIdentifier: "MyVideosTableViewCellID")
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMyVideosList()
    }
    
    // MARK: UITableViewDataSovare Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TemplatesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyVideosTableViewCellID", for: indexPath) as! MyVideosTableViewCell
        let template = TemplatesList[indexPath.row]
        cell.delegate = self
        cell.updateViewData(template: template)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    fileprivate func getMyVideosList()
    {
        NetworkManager.Instance.getRequestData(APIConstants.GET_MYVIDEOS, userAuthParameters: AppHelper.Instance.getUserAuthParameters(), withCompletionHandler: { (response) in
            
            print("RESTTTTTT: getMyVideosList "+response.description)
            
            for data in response.array!
            {
                let dic = Template(id: data["id"].description, status: data["status"].description, draft_status: data["draft_status"].description, category: data["category"].description,  duration: data["duration"].description, categoryName: data["category_name"].description, type: data["type"].description.description, price: data["price"].description , priceInr: data["price_inr"].description , priceSar: data["price_sar"].description , code: data["code"].description ?? "", templateTitle: data["template_title"].description ?? "", thumbnail: data["thumbnail"].description ?? "", video: data["video"].description ?? "", definition: data["definition"].description ?? "", createdAt: data["created_at"].description ?? "", updatedAt: data["updated_at"].description ?? "", baseURL: BaseURL(rawValue: data["base_url"].description ))
                
                self.TemplatesList.append(dic)
            }
         
            self.myVideosTableView.reloadData()
            
        })
    }
    
    // MARK:- MyVideosTableViewCellDelegate Methods
    
    func didDeleteVideoButtonClicked(cell: MyVideosTableViewCell) {
    
    }
    
    func didShareButtonClicked(cell: MyVideosTableViewCell) {
    
    }
    
    func didVideoImageButtonClicked(cell: MyVideosTableViewCell) {
    
        let indexPath = self.myVideosTableView.indexPath(for: cell)
        if let template = TemplatesList[indexPath!.row] as? Template, template != nil, template.id != nil, template.id?.description.count ?? 0 > 0
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "TemplateViewControllerID") as! TemplateViewController
            vc.templateInfo = template
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
