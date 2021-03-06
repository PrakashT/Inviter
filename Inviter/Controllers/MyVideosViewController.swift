//
//  MyVideosViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/25/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD

class MyVideosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyVideosTableViewCellDelegate
{
    
    @IBOutlet weak var noVideosView: UIView!
    @IBOutlet weak var broseTemplatesButton: UIButton!
    
    @IBOutlet weak var myVideosTableView: UITableView!
    private var TemplatesList = [Template]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myVideosTableView.register(UINib.init(nibName: "MyVideosTableViewCell", bundle: nil), forCellReuseIdentifier: "MyVideosTableViewCellID")
        
        broseTemplatesButton.layer.borderWidth = 2.0
        broseTemplatesButton.layer.borderColor = AppHelper.Instance.appLogoColor().cgColor
        broseTemplatesButton.layer.cornerRadius = broseTemplatesButton.frame.height/2.0
        
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
        noVideosView.isHidden = true;
        
        MBProgressHUD.showAdded(to: self.view, animated: true)

        NetworkManager.Instance.getRequestData(APIConstants.GET_MYVIDEOS, userAuthParameters: AppHelper.Instance.getUserAuthParameters(), withCompletionHandler: { (response) in
            if let responseArray = response.array
           {
            self.noVideosView.isHidden = (responseArray.count > 0);

            self.TemplatesList.removeAll()
            
            print("RESTTTTTT: getMyVideosList "+response.description)

            for data in responseArray
            {
                let dic = Template(id: data["id"].description, status: data["status"].description, draft_status: data["draft_status"].description, category: data["category"].description,  duration: data["duration"].description, categoryName: data["category_name"].description, type: data["type"].description.description, price: data["price"].description , priceInr: data["price_inr"].description , priceSar: data["price_sar"].description , code: data["code"].description ?? "", templateTitle: data["template_title"].description ?? "", thumbnail: data["thumbnail"].description ?? "", video: data["video"].description ?? "", definition: data["definition"].description ?? "", createdAt: data["created_at"].description ?? "", updatedAt: data["updated_at"].description ?? "", baseURL: BaseURL(rawValue: data["base_url"].description ))
                
                self.TemplatesList.append(dic)
            }
                self.myVideosTableView.reloadData()
            }
            else
            {
                self.noVideosView.isHidden = false
            }
           
            MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
    // MARK:- MyVideosTableViewCellDelegate Methods
    
    func didDeleteVideoButtonClicked(cell: MyVideosTableViewCell) {
        if let videoID = cell.templateInfo.id, videoID.count > 0
        {
            MBProgressHUD.showAdded(to: self.view, animated: true)

            NetworkManager.Instance.postRequestWithFormData(Dictionary<String, String>(), headerParameters: AppHelper.Instance.getUserAuthParameters(), url: APIConstants.POST_DELETE_MyVIDEOS+videoID, withCompletionHandler: { (result) in
                
                MBProgressHUD.hide(for: self.view, animated: true)

                let filteredDetails = self.TemplatesList.filter { !$0.id!.contains(videoID) }
                self.TemplatesList = filteredDetails
                
                self.myVideosTableView.reloadData()

            })
        }
       
    }
    
//    enum StatusType {
//        case DraftInprogressType
//        case DraftSuccessType
//        case FinalInprogressType
//        case FinalSuccessType
//        case DraftOrFinalFailedType
//    }
    
    func didShareButtonClicked(cell: MyVideosTableViewCell) {
      
        switch cell.statusType {
        case .DraftSuccessType? , .DraftOrFinalFailedType?: // EDIT
            editThisTemplateButtonClicked(templateInfo: cell.templateInfo)
            break
        case .FinalSuccessDownloadType?: // DOWNLOAD
            
            break
        case .FinalSuccessShareType?: // SHARE
            displayShareSheet(localVideoPath: cell.templateInfo.video ?? "")
            break
        default:
            break
        }
    }
    
    func didVideoImageButtonClicked(cell: MyVideosTableViewCell) {
    
        let indexPath = self.myVideosTableView.indexPath(for: cell)
        if let template = TemplatesList[indexPath!.row] as? Template, template != nil, template.video != nil, template.video?.description.count ?? 0 > 0
        {
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "TemplateViewControllerID") as! TemplateViewController
//            vc.templateInfo = template
//            self.navigationController?.pushViewController(vc, animated: true)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "VideoPlayerViewControllerID") as! VideoPlayerViewController
            vc.videoURL = template.video
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK:-  Status Type Operations
    
    func editThisTemplateButtonClicked(templateInfo: Template)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TemplateEditViewControllerID") as! TemplateEditViewController
        vc.templateInfo = templateInfo
        vc.isFromMyVideos = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func displayShareSheet(localVideoPath:String) {
        
        //        let localVideoPath = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        let videoURL = URL(fileURLWithPath: localVideoPath)
        
        let activityItems: [Any] = [localVideoPath, "Check this out!"]
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = view
        activityController.popoverPresentationController?.sourceRect = view.frame
        
        self.present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func browseTemplatesButtonClicked(_ sender: Any)
    {
        self.tabBarController?.selectedIndex = 0
    }
    
}
