//
//  CategoryCollectionHeaderView.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 10/1/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class CategoryCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    @IBOutlet weak var categoryDescriptionLbl: UILabel!

    private var parentVC: CategoryDetailViewController!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation. */
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
 
    @IBAction func backButtonClicked(sender: UIButton) {
        parentVC.navigationController?.popViewController(animated: true)
    }
    
    func setUpViewData(category: Category, parent: CategoryDetailViewController)
    {
        parentVC = parent
        if categoryTitleLbl != nil
        {
            categoryTitleLbl.text = category.categoryName.description
            categoryDescriptionLbl.text = category.categoryName.description + " Invitation Templates"
            if(category.image.capitalized != "empty".capitalized && category.image.count > 5)
            {
                categoryImageView.sd_setImage(with: URL(string:category.image), completed: { (image, err, type, url) in
                    //                self.activityIndicator.stopAnimating()
                })        }
        }
    }
    
    func setUpAllTemplatesViewData(parent: CategoryDetailViewController)
    {
        parentVC = parent
        if categoryTitleLbl != nil
        {
            categoryTitleLbl.text = "All Templates"
            categoryDescriptionLbl.text = "All Templates From Inviter"
           categoryImageView.image = UIImage.init(named: "category_cover_other")
        }
    }

}
