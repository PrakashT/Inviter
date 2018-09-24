//
//  TemplateTextFieldTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/1/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class TemplateTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    var nextTextField:UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTag(tag: Int){
        textField.tag = 100+tag
    }
    
}

extension TemplateTextFieldTableViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nextTextField?.tag == (textField.tag)
        {
            return textField.resignFirstResponder()
        }
        return false
    }
}
