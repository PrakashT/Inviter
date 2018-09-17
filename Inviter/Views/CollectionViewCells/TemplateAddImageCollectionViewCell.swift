//
//  TemplateAddImageCollectionViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/5/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

protocol TemplateAddImageCollectionViewCellDelegate:class {
   func addImageButton1Clicked(_ sender: UIButton)
    func addImageButton2Clicked(_ sender: UIButton)
}

class TemplateAddImageCollectionViewCell: UICollectionViewCell {

   weak var delegate: TemplateAddImageCollectionViewCellDelegate?
    @IBOutlet weak var emptyAddImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addImageButton1Clicked(_ sender: UIButton)
    {
        delegate?.addImageButton1Clicked(sender)
    }
    
    @IBAction func addImageButton2Clicked(_ sender: UIButton)
    {
        delegate?.addImageButton2Clicked(sender)
    }
}
