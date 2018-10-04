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

enum StatusType {
    case DraftInprogressType
    case DraftSuccessType
    case FinalInprogressType
    case FinalSuccessDownloadType
    case FinalSuccessShareType
    case DraftOrFinalFailedType
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
    @IBOutlet weak var createdDateLbl: UILabel!
    
    var delegate:MyVideosTableViewCellDelegate?
    var statusType:StatusType!
    var templateInfo:Template!
    
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
        templateInfo = template
        
        videoTypeLbl.text = template.type?.description
        durationLbl.text = AppHelper.Instance.secondsToTimestamp(intSeconds: Int(template.duration ?? "0") ?? 0)
        categoryLbl.text = template.categoryName?.description
//        statusLbl.text = template.draft_status?.description
        videoTitleLbl.text = template.templateTitle?.description
//        shareButton.titleLabel?.text = (template.draft_status?.description.lowercased() == "final") ? "SHARE" : "EDIT"
        
        if template.draft_status?.description.lowercased() == "draft" && template.status?.description.lowercased() == "inprogress"
        {
            statusType = StatusType.DraftInprogressType
         
            statusLbl.text = "Inprogress"
            shareButton.setTitle("Edit", for: .normal)
            shareButton.isUserInteractionEnabled = false
            deleteButton.isUserInteractionEnabled = false
        }
        else if template.draft_status?.description.lowercased() == "final" && template.status?.description.lowercased() == "inprogress"
        {
            statusType = StatusType.FinalInprogressType
            
            statusLbl.text = "Inprogress"
            shareButton.setTitle("Download", for: .normal)
            shareButton.isUserInteractionEnabled = false
            deleteButton.isUserInteractionEnabled = false
        }
        else if template.draft_status?.description.lowercased() == "draft" && template.status?.description.lowercased() == "success"
        {
            statusType = StatusType.DraftSuccessType
            
            statusLbl.text = "Draft"
            shareButton.setTitle("Edit", for: .normal)
            shareButton.isUserInteractionEnabled = true
            deleteButton.isUserInteractionEnabled = true
        }
        else if template.draft_status?.description.lowercased() == "final" && template.status?.description.lowercased() == "success"
        {
            statusType = StatusType.FinalSuccessDownloadType
            
            statusLbl.text = "Completed"
            shareButton.setTitle("Download", for: .normal)//TODO: Check file Download or not if yes 'Download' else 'SHARE'
            shareButton.isUserInteractionEnabled = true
            deleteButton.isUserInteractionEnabled = true
        }
        else // If Failed + Draft Or Failed + Final
        {
            statusType = StatusType.DraftOrFinalFailedType
            
            statusLbl.text = "Failed"
            shareButton.setTitle("Edit", for: .normal)
            shareButton.isUserInteractionEnabled = true
            deleteButton.isUserInteractionEnabled = true
        }
        
        createdDateLbl.text = template.updatedAt?.description
        
        if(template.thumbnail?.lowercased() != "empty" && template.thumbnail?.description.count ?? 0 > 5)
        {
            videoImgView.sd_setImage(with: URL(string:APIConstants.S3_BASE_URL+(template.thumbnail?.description ?? "")), completed: { (image, err, type, url) in

            })
        }
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
