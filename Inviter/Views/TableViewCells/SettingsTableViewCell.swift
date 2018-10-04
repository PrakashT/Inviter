//
//  SettingsTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 10/4/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var InfoLbl: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var separatorLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
