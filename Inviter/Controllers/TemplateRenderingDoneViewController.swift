//
//  TemplateRenderingDoneViewController.swift
//  Inviter
//
//  Created by People Tech on 29/08/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import MBProgressHUD

class TemplateRenderingDoneViewController: UIViewController
{
//    @IBOutlet weak var musicListTableView: UITableView!
    @IBOutlet weak var notifyMeButton: UIButton!
    @IBOutlet weak var continueBrowsingButton: UIButton!
    
    @IBOutlet weak var templateImageView: UIImageView!
//    @IBOutlet weak var templateTitleLbl: UILabel!
    @IBOutlet weak var viewPlay: UIView!
    @IBOutlet weak var playImageView: UIImageView!
    
    var player : AVPlayer?
    var renderedVideoDic = [String: String]()
    var templateInfo : Template!
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueBrowsingButton.layer.cornerRadius = (continueBrowsingButton.frame.height)/2
        notifyMeButton.layer.cornerRadius = (notifyMeButton.frame.height)/2
        notifyMeButton.layer.borderColor = AppHelper.Instance.appLogoColor().cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MBProgressHUD.showAdded(to: viewPlay, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    @IBAction func continueBrosingButtonClicked(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func notifyMeButtonClicked(_ sender: UIButton) {
        
        sender.setTitle("", for: .normal)
        sender.backgroundColor = UIColor.clear
    }
    
    func updateVideoData()  {
        if(templateInfo != nil && templateInfo.thumbnail != "Empty" && (templateInfo.thumbnail?.count ?? 0) > 5)
        {
            templateImageView.sd_setImage(with: URL(string: templateInfo.thumbnail ?? ""), completed: { (image, err, type, url) in
                //                self.activityIndicator.stopAnimating()
            })
            playImageView.image = UIImage.init(named: "play_whiteBig")
        }
    }
    
    @IBAction func editButtonnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playVideoButtonClicked(_ sender: UIButton) {
        
        if let url = NSURL(string: templateInfo.video ?? "")
        {
            viewPlay.isHidden = false
            
            if player == nil
            {
                player = AVPlayer(url: url as URL)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.viewPlay.bounds
                //        playerLayer.backgroundColor = UIColor.yellow.cgColor
                //        let affineTransform = CGAffineTransform(rotationAngle:(.pi * 90.0 / 180.0))
                //        playerLayer.setAffineTransform(affineTransform)
                
                self.viewPlay.layer.addSublayer(playerLayer)
            }
            
            if !sender.isSelected
            {
                player?.play();
                playImageView.image = nil
            }
            else
            {
                playImageView.image = UIImage.init(named: "play_whiteBig")
                player?.pause();
            }
            sender.isSelected = !sender.isSelected
        }
    }
    
    func checkVideoRenderingDone()
    {
        NetworkManager.Instance.getRequestData(APIConstants.GET_RENDERER_STATUS+(renderedVideoDic["taskid"]?.description)!
) { (result) in
            
            print("assaSAs", result.dictionary)
            for data in result.dictionary!
            {
                print("data", data)
               if data.key == "status" && data.value == "SUCCESS"
               {
                MBProgressHUD.hide(for: self.viewPlay, animated: true)

                self.updateVideoData()
                self.timer.invalidate()
                }
                //                if let mblVideoId = data["mobileVideoID"]!.string
                //                {
                //                    self.mobileVideoID = mblVideoId
                //                }
            }
        }
    }
    
    func startRendererVideo(isFinalVideo: Bool, templateDifinition : TemplateDefinition, templateDic : Template)
    {
        let userId = UserDefaults.standard.value(forKey: "userID") as! String
        let emailId = UserDefaults.standard.value(forKey: "emailID") as! String
        
        let rendererRequest = RendererRequest(categoryName:templateDic.categoryName!, code:templateDic.code!, duration:"", emailID:emailId, mobileVideoID: renderedVideoDic["mobileVideoID"]?.description ?? "", templateID: templateDic.code!, template: templateDic.id!, type:templateDic.type!, userID:userId, resources: templateDifinition.resources)
        
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
        NetworkManager.Instance.postRequestWithRawValue(jsonString, headerParameters: AppHelper.Instance.getUserAuthParameters(), url: urlOfRendrerType) { (result) in
            
            print("assaSAs", result.dictionary)
            for data in result.dictionary!
            {
                print("data", data)
                self.renderedVideoDic[data.key] = data.value.description

                if (data.key == "taskid")
                {
                    self.timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) {
                        (_) in
                        self.checkVideoRenderingDone()
                    }
                }
            }
        }
    }
}

