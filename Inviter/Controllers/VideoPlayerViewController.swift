//
//  VideoPlayerViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 10/5/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import MediaPlayer
import MBProgressHUD

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var viewPlay: UIView!
    var videoURL:String!
    var player : AVPlayer?
    @IBOutlet weak var playImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playVideoButtonClicked(UIButton())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playVideoButtonClicked(_ sender: UIButton) {
        
        if let url = NSURL(string: videoURL)//"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        {
            viewPlay.isHidden = false
            
            if player == nil
            {
                player = AVPlayer(url: url as URL)
                player?.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate" {
            if Double(player?.rate ?? 0)  > 0 {
                print("video started")
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}
