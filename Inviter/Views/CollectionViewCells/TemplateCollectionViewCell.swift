//
//  TemplateCollectionViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/24/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class TemplateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(template: Template)
    {
        titleLabel.text = template.templateTitle
        if(template.thumbnail != "Empty" && template.thumbnail.count > 5)
        {
            thumbnailImageView.sd_setImage(with: URL(string:template.thumbnail), completed: { (image, err, type, url) in
                //                self.activityIndicator.stopAnimating()
            })        }
    }

}
