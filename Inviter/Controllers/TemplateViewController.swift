//
//  TemplateViewController.swift
//  Inviter
//
//  Created by People Tech on 29/08/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class TemplateViewController: UIViewController
{
    @IBOutlet weak var editThisTemplateButton: UIButton!
    @IBOutlet weak var templateImageView: UIImageView!
    @IBOutlet weak var templateTitleLbl: UILabel!
    @IBOutlet weak var viewPlay: UIView!
    @IBOutlet weak var playImageView: UIImageView!
    
    var templateInfo : Template!
    var player : AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editThisTemplateButton.layer.cornerRadius = (editThisTemplateButton.frame.height/2)
        templateTitleLbl.text = templateInfo.templateTitle ?? "No Title"
        
        if(templateInfo != nil && templateInfo.thumbnail != "Empty" && (templateInfo.thumbnail?.count ?? 0) > 5)
        {
            templateImageView.sd_setImage(with: URL(string: templateInfo.thumbnail ?? ""), completed: { (image, err, type, url) in
                //                self.activityIndicator.stopAnimating()
            })
        }
    }
    
//    func degreeToRadian(_ x: CGFloat) -> CGFloat {
//        return
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playVideoButtonClicked(_ sender: UIButton) {
        
        if let url = NSURL(string: templateInfo.video ?? "")//"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
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
    
    @IBAction func editThisTemplateButtonClicked(_ sender: UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TemplateEditViewControllerID") as! TemplateEditViewController
        vc.templateInfo = templateInfo
        vc.isFromMyVideos = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
