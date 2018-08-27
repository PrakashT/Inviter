//
//  Categories.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/26/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import Foundation

typealias Categories = [Category]

struct Category {
    var id: Int
    var categoryName: String
    var generic: Generic
    var image, firebaseID: String
    var createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case generic, image
        case firebaseID = "firebase_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum Generic: String {
    case generic = "generic"
    case specific = "specific"
}
