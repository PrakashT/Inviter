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

class TemplateEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TemplateAddImageTableViewCellDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var templateTableView: UITableView!
    
    let sectionHeaderTitlesList: [String] = ["", "Music", "Edit Text", ""]
    private var templateDifinition : TemplateDefinition!
    private var myVideoDifinition : MyVideoTemplateDefinition!
    var templateInfo : Template!
    var textFieldsDic = [String: UITextField]()
    var nextTextField:UITextField?
    var isFromMyVideos = false
    
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
        
        setupKeyboardNotifications()
    }
    
    func setupKeyboardNotifications()  {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setTemplateDetails()
    {
        let definitionJsonStr = templateInfo.definition
        let data = definitionJsonStr?.data(using: .utf8)!
        do {
            if !isFromMyVideos && templateDifinition == nil
            {
                templateDifinition = try JSONDecoder().decode(TemplateDefinition.self, from: data!)
            }
            else if isFromMyVideos && myVideoDifinition == nil
            {
                myVideoDifinition = try JSONDecoder().decode(MyVideoTemplateDefinition.self, from: data!)
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTemplateDetails()
        
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
            if templateDifinition.resources.images != nil
            {
                cell.setupViewData(imagesDatalist: (templateDifinition.resources.images))
            }
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
            cell.textField.delegate = self
            cell.setTag(tag: indexPath.row)
            
            textFieldsDic[cell.textField.tag.description] = cell.textField
            
//            cell.nextTextField = { [weak self] (tag) in
//                guard let strongSelf = self else{
//                    return
//                }
//
//                strongSelf.formTableView.nextResponder(index: tag)
//            }
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
    
    func checkAllTheRequiredData() -> Bool {
        
        var isAllImagesAdded = true
        for imgInfo in templateDifinition.resources.images
        {
            if imgInfo.s3Object.count == 0
            {
                isAllImagesAdded = false
                break
            }
        }
        
        var isAllTextsAdded = true
        for textInfo in templateDifinition.resources.texts
        {
            if textInfo.value.count == 0
            {
                isAllTextsAdded = false
                break
            }
        }

        return isAllImagesAdded && isAllTextsAdded
    }
    
    func startRendererVideo(isFinalVideo: Bool)
    {
        if !checkAllTheRequiredData()
        {
            AppHelper.Instance.ShowAlertView(title: "Inviter", message: "Please make sure you upload all the images and edit the text!", selfVC: self)
            return
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TemplateRenderingDoneViewControllerID") as! TemplateRenderingDoneViewController
        vc.isFinalVideo = isFinalVideo
        vc.templateDifinition = templateDifinition
        vc.templateInfo = templateInfo
        self.navigationController?.pushViewController(vc, animated: true)
//        vc.startRendererVideo(isFinalVideo: true, templateDifinition: templateDifinition, templateDic: templateInfo)
    }
    
    @objc func generatePreviewButtonClicked(sender: UIButton)
    {
        startRendererVideo(isFinalVideo: false)
    }
    
    @objc func fullVideoRenderedButtonClicked(sender: UIButton)
    {
        startRendererVideo(isFinalVideo: true)
    }
    
    @IBAction func tapGestureHandle(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButtonClicked(_ sender: Any)
    {
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Handle Keyboard Notify Methods
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardFrame.height + 20
        templateTableView.keyboardRaised(height: height)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        templateTableView.keyboardClosed()
    }
    
    // MARK: - UITextFields Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let nextTxtFieldTag = textField.tag+1
        if nextTxtFieldTag < templateDifinition.resources.texts.count+100 && textFieldsDic[String(nextTxtFieldTag)] != nil // For comparing with actual index value adding constant number 100
        {
            nextTextField = textFieldsDic[String(nextTxtFieldTag)]
            textField.returnKeyType = .next
        }
        else
        {
            nextTextField = nil
            textField.returnKeyType = .done
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let text = textField.text, let textRange = Range(range, in: text)
        {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            templateDifinition.resources.texts[textField.tag-100].updateTextValue(text: updatedText)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if nextTextField == nil
        {
            textField.resignFirstResponder()
            return true
        }
        else
        {
            nextTextField?.becomeFirstResponder()
            return false
        }
    }
}


