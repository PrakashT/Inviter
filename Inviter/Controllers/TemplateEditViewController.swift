//
//  TemplateEditViewController.swift
//  Inviter
//
//  Created by People Tech on 29/08/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

enum InputType:Int {
    case ImageType = 0
    case MusicType = 1
    case TextFieldType = 2
}

class TemplateEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TemplateAddImageTableViewCellDelegate {
    
    @IBOutlet weak var templateTableView: UITableView!
    
    let sectionHeaderTitlesList: [String] = ["", "Music", "Edit Text", ""]
    private var templateDifinition : TemplateDefinition!
    var templateInfo : Template!
    var mobileVideoID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        templateTableView.regivarr(UIvar.init(nibName: "TemplateAddImageTableViewCell"varundlevarl), varCellReuseIdentifier: "TemplateAddImageTableViewCellID")
        
        templateTableView.register(UINib.init(nibName: "TemplateAddImageTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateAddImageTableViewCellID")
        
        templateTableView.register(UINib.init(nibName: "TemplateEditMusicTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateEditMusicTableViewCellID")
        
        templateTableView.register(UINib.init(nibName: "TemplateTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateTextFieldTableViewCellID")
        
        templateTableView.register(UINib.init(nibName: "TemplateEditButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TemplateEditButtonsTableViewCellID")
        
        templateTableView.rowHeight = UITableViewAutomaticDimension
        templateTableView.estimatedRowHeight = 55.0
        templateTableView.needsUpdateConstraints()
        
        setTemplateDetails()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setTemplateDetails()
    {
        let definitionJsonStr = templateInfo.definition
        let data = definitionJsonStr?.data(using: .utf8)!
        do {
            templateDifinition = try JSONDecoder().decode(TemplateDefinition.self, from: data!)
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: UITableView DataSources
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitlesList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return templateDifinition == nil ? 0 : (templateDifinition.resources.texts.count)
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateAddImageTableViewCellID", for: indexPath) as! TemplateAddImageTableViewCell
            cell.parentVC = self
            cell.setupViewData(imagesDatalist: (templateDifinition.resources.images))
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateEditMusicTableViewCellID", for: indexPath) as! TemplateEditMusicTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateEditButtonsTableViewCellID", for: indexPath) as! TemplateEditButtonsTableViewCell
            cell.generatePreviewButton.addTarget(self, action: #selector(generatePreviewButtonClicked(sender:)), for: .touchUpInside)
            cell.fullVideoRenderedButton.addTarget(self, action: #selector(fullVideoRenderedButtonClicked(sender:)), for: .touchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateTextFieldTableViewCellID", for: indexPath) as! TemplateTextFieldTableViewCell
            cell.textField.placeholder = templateDifinition.resources.texts[indexPath.row].value
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 16, width:
            tableView.bounds.size.width, height: 56))
        headerLabel.font = UIFont(name: "Verdana", size: 23)
        headerLabel.textColor = AppHelper.Instance.appLogoColor()
        headerLabel.text = sectionHeaderTitlesList[section]
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0 || section == sectionHeaderTitlesList.count-1) ? 0 : 56
    }
    
    func didUpdateImageInfo(imageInfo:Image, s3Object:String)
    {
        if let index = templateDifinition.resources.images.index(where: { $0.index == imageInfo.index }) {
            templateDifinition.resources.images[index].updateS3ObjectInfo(s3ObjectValue: s3Object, fileLocationValue: APIConstants.S3_BASE_URL+s3Object)
        }
    }
    
//    var template: String
//    var type: String
//    var userID: String
//
//    //    var videoID: String
//    //    var templateLength: String
//
//    var resources:Resources
    
    func startRendererVideo(isFinalVideo: Bool)
    {
        let userId = UserDefaults.standard.value(forKey: "userID") as! String
        let emailId = UserDefaults.standard.value(forKey: "emailID") as! String

        let rendererRequest = RendererRequest(categoryName:templateInfo.categoryName!, code:templateInfo.code!, duration:"", emailID:emailId, mobileVideoID: mobileVideoID, templateID: templateInfo.code!, template: templateInfo.id!, type:templateInfo.type!, userID:userId, resources: templateDifinition.resources)
        
        let jsonEncoder = JSONEncoder()
        var parameters: Dictionary<String, Any>?
        var jsonString = ""
        do {
            let jsonData = try jsonEncoder.encode(rendererRequest)
            jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonString)
//             jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!

            //replacingOccurrences(of: "\", with: "", options: NSString.CompareOptions.literal, range: nil)

            parameters = try (JSONSerialization.jsonObject(with: jsonData, options: []) as? Dictionary<String, Any>)!
//            parameters = jsonString.convertToDictionary()
        } catch let error as NSError {
            print(error)
            return
        }
        
//        let parameters = rendererRequest.dictionaryParameters
        let urlOfRendrerType = isFinalVideo ?  APIConstants.POST_START_RENDERER_PROCESS_FINAL+"true" : APIConstants.POST_START_RENDERER_PROCESS
        NetworkManager.Instance.postRequestData(jsonString, headerParameters: AppHelper.Instance.getUserAuthParameters(), url: urlOfRendrerType) { (result) in
            
            print("assaSAs", result.dictionary)
            for data in result.dictionary!
            {
                print("data", data)

//                if let mblVideoId = data["mobileVideoID"]!.string
//                {
//                    self.mobileVideoID = mblVideoId
//                }
            }
           
        }
    }
    
    @objc func generatePreviewButtonClicked(sender: UIButton)
    {
        startRendererVideo(isFinalVideo: false)
    }
    
    @objc func fullVideoRenderedButtonClicked(sender: UIButton)
    {
        startRendererVideo(isFinalVideo: true)
    }
    
    @IBAction func backButtonClicked(_ sender: Any)
    {
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.popViewController(animated: true)
    }
}


