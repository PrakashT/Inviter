//
//  CategoryHeaderCollectionViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/30/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryHeaderCollectionViewCell: UICollectionViewCell {
    
    //    @IBOutlet weak var backButton: UIButton!
    //    @IBOutlet weak var categoryImageView: UIImageView!
    //    @IBOutlet weak var categoryTitleLbl: UILabel!
    private var parentVC:CategoryDetailViewController!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setUpViewData(category: Category, parent: CategoryDetailViewController)
    {
        parentVC = parent
        
        if titleLbl != nil
        {
            titleLbl.text = category.categoryName.description
            if(category.image.capitalized != "empty".capitalized && category.image.count > 5)
            {
                imgView.sd_setImage(with: URL(string:category.image), completed: { (image, err, type, url) in
                    //                self.activityIndicator.stopAnimating()
                })        }
        }
    }
    
    @IBAction func backButtonClicked(sender: UIButton) {
        parentVC.navigationController?.popViewController(animated: true)
    }
}

