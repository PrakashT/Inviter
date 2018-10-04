//
//  MyVideosTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/25/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

protocol MyVideosTableViewCellDelegate {
    
    func didDeleteVideoButtonClicked(cell: MyVideosTableViewCell)
    func didShareButtonClicked(cell: MyVideosTableViewCell)
    func didVideoImageButtonClicked(cell: MyVideosTableViewCell)
}

class MyVideosTableViewCell: UITableViewCell {
   
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var videoTypeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var videoTitleLbl: UILabel!
    @IBOutlet weak var videoImgView: UIImageView!
    
     var delegate:MyVideosTableViewCellDelegate?
    
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
    
    func updateViewData(template: Template)
    {
        videoTypeLbl.text = template.type?.description
        durationLbl.text = AppHelper.Instance.secondsToTimestamp(intSeconds: Int(template.duration ?? "0") ?? 0)
        categoryLbl.text = template.categoryName?.description
        statusLbl.text = template.draft_status?.description
        videoTitleLbl.text = template.templateTitle?.description
        shareButton.titleLabel?.text = (template.draft_status?.description.lowercased() == "final") ? "SHARE" : "EDIT"
        
        if(template.thumbnail?.lowercased() != "empty" && template.thumbnail?.description.count ?? 0 > 5)
        {
            videoImgView.sd_setImage(with: URL(string:APIConstants.S3_BASE_URL+(template.thumbnail?.description ?? "")), completed: { (image, err, type, url) in

            })        }
    }
    
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.didDeleteVideoButtonClicked(cell: self)
    }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        delegate?.didShareButtonClicked(cell: self)
    }
    
    @IBAction func videoImageButtonClicked(_ sender: Any) {
        delegate?.didVideoImageButtonClicked(cell: self)
    }
    
}
