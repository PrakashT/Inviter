//
//  RendererRequest.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/23/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

struct RendererRequest: Codable {
    var templateID: String
    var userID: String
    var emailID: String
    var template: String
    var videoID: String
    var templateLength: String

    var resources:Resources
    
    var dictionaryParameters: [String: Any] { return ["templateID": templateID, "userID": userID, "emailID":emailID, "template": template, "videoID": videoID, "templateLength": templateLength,  "Resources": templateLength, "resources":resources] }

}
