//
//  MyVideoTemplateDefinition.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 10/5/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import Foundation

struct MyVideoTemplateDefinition: Codable {
    
    let emailID, templateID, userID: String?
    var resources: Resources

//    enum CodingKeys: String, CodingKey {
//        case emailID, templateID, userID
//    }
}
