//
//  MyVideosTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/25/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class MyVideosTableViewCell: UITableViewCell {
   
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shareButton.layer.borderColor = UIColor(red:0.82, green:0.15, blue:0.49, alpha:1).cgColor
        
        deleteButton.layer.borderColor = UIColor(red:0.44, green:0.57, blue:0.71, alpha:1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
    }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
    }
    
    
}
