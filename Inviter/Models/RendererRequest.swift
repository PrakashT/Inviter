//
//  RendererRequest.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/23/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

struct RendererRequest: Codable {
    var categoryName: String
    var code: String
    var duration: String
    var emailID: String
    var mobileVideoID: String
    var templateID: String
    var template: String
    var type: String
    var userID: String

//    var videoID: String
//    var templateLength: String
    
    var resources:Resources
    
    var dictionaryParameters: [String: Any] { return ["categoryName":categoryName, "code":code, "duration":duration, "emailID":emailID, "mobileVideoID": mobileVideoID, "templateID": templateID, "template": template, "type":type, "userID":userID, "Resources": resources] }

}
