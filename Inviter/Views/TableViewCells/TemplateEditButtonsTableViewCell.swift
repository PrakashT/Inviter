//
//  TemplateEditButtonsTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/1/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class TemplateEditButtonsTableViewCell: UITableViewCell {

    @IBOutlet weak var fullVideoRenderedButton: UIButton!
    @IBOutlet weak var generatePreviewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        generatePreviewButton.layer.borderColor = AppHelper.Instance.appLogoColor().cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
