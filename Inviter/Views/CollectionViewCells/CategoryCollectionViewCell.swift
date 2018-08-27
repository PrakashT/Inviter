//
//  CategoryCollectionViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/24/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bGView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dropShadow(viewShadow: bGView)
    }
    
    func updateData(category: Category)
    {
        titleLabel.text = category.categoryName
        if(category.image != "Empty" && category.image.count > 5)
        {
            thumbnailImageView.sd_setImage(with: URL(string:category.image), completed: { (image, err, type, url) in
//                self.activityIndicator.stopAnimating()
            })        }
    }

    func dropShadow(viewShadow: UIView) {
        viewShadow.layer.cornerRadius = 5
//        viewShadow.layer.shadowColor = UIColor.black.cgColor
//        viewShadow.layer.shadowOpacity = 10
//        viewShadow.layer.shadowOffset = CGSize.zero
//        viewShadow.layer.shadowRadius = 0
    }
}
