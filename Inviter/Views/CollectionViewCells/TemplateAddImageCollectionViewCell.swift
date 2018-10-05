//
//  TemplateAddImageCollectionViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/5/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

protocol TemplateAddImageCollectionViewCellDelegate:class {
    func addImageButtonClicked(_ imageBGView: UIView, imageView: UIImageView, imageInfo: Image)
    
    func removeImageInfo(imageInfo: Image)
}

class TemplateAddImageCollectionViewCell: UICollectionViewCell {

   weak var delegate: TemplateAddImageCollectionViewCellDelegate?
    
    @IBOutlet weak var emptyAddImageBGView1: UIView!
    @IBOutlet weak var filledImageBGView1: UIView!
    @IBOutlet weak var imageView1: UIImageView!

    @IBOutlet weak var imageBGView2: UIView!
    @IBOutlet weak var emptyAddImageBGView2: UIView!
    @IBOutlet weak var filledImageBGView2: UIView!
    @IBOutlet weak var imageView2: UIImageView!
    
    private var imagedetails1: Image!
    private var imagedetails2: Image!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView1.layer.cornerRadius = 15.0
        imageView2.layer.cornerRadius = 15.0
    }
    
    
    func setupViewData(imageInfo1: Image, imageInfo2: Image?, imagesDic: [String:UIImage])
    {
        imagedetails1 = imageInfo1
        imagedetails2 = imageInfo2
        
        if(imageInfo1.s3Object != "Empty" && (imageInfo1.s3Object.count) > 5)
        {
            filledImageBGView1.isHidden = false
            imageView1.sd_setImage(with: URL(string: APIConstants.S3_BASE_URL+imageInfo1.s3Object), completed: { (image, err, type, url) in
                //                self.activityIndicator.stopAnimating()
            })
        }
        else
        {
            filledImageBGView1.isHidden = true
        }
        
        if imageInfo2 == nil
        {
            emptyAddImageBGView2.isHidden = true
            filledImageBGView2.isHidden = true
        }
        else
        {
            emptyAddImageBGView2.isHidden = false
            filledImageBGView2.isHidden = false
            
            let s3ObjImage = imageInfo2?.s3Object ?? ""
            if(s3ObjImage != "Empty" && (s3ObjImage.count) > 5)
            {
                filledImageBGView2.isHidden = false
                imageView2.sd_setImage(with: URL(string: APIConstants.S3_BASE_URL+s3ObjImage), completed: { (image, err, type, url) in
                    //                self.activityIndicator.stopAnimating()
                })
            }
            else
            {
                filledImageBGView2.isHidden = true
            }
        }
        
        if imagesDic.count > 0
        {
            if let image1 = imagesDic[imageInfo1.index.description]
            {
                filledImageBGView1.isHidden = false
                imageView1.image = image1
            }
            if imageInfo2 != nil, let image2 = imagesDic[(imageInfo2?.index.description)!]
            {
                filledImageBGView2.isHidden = false
                imageView2.image = image2
            }
        }
    }
    
    @IBAction func removeImageButton1Clicked(_ sender: UIButton) {
        imageView1.image = UIImage()
        filledImageBGView1.isHidden = true
    }
    
    @IBAction func removeImageButton2Clicked(_ sender: UIButton) {
        imageView2.image = UIImage()
        filledImageBGView2.isHidden = true
    }
    
    @IBAction func addImageButton1Clicked(_ sender: UIButton)
    {
        delegate?.addImageButtonClicked(filledImageBGView1,imageView: imageView1, imageInfo: imagedetails1)
    }
    
    @IBAction func addImageButton2Clicked(_ sender: UIButton)
    {
        delegate?.addImageButtonClicked(filledImageBGView2,imageView: imageView2, imageInfo: imagedetails2)
    }
}
