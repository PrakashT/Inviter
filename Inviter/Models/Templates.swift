//
//  Templates.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/26/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import Foundation
// To parse the JSON, add this file to your project and do:
//
//   let templates = try? newJSONDecoder().decode(Templates.self, from: jsonData)

import Foundation

typealias Templates = [Template]

struct Template: Codable {
    let id,status,draft_status,category: String?
    let duration: String?
    let categoryName: String?
    let type: String?
    let price, priceInr, priceSar, code: String?
    var templateTitle, thumbnail, video, definition: String?
    let createdAt, updatedAt: String?
    let baseURL: BaseURL?
    
    enum CodingKeys: String, CodingKey {
        case id, category,draft_status,status
        case categoryName = "category_name"
        case duration = "duration"
        case type  = "type"
        case price = "price"
        case priceInr = "price_inr"
        case priceSar = "price_sar"
        case code = "code"
        case templateTitle = "template_title"
        case thumbnail, video, definition
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case baseURL = "base_url"
    }
    
    mutating func updateVideoInfo(videoValue: String) {
        video = videoValue
    }
    
    mutating func updateThumbnailInfo(thumbnailValue: String)
    {
        thumbnail = thumbnailValue
    }
}

enum BaseURL: String, Codable {
    case httpsEtsVideooutputTstS3AmazonawsCOM = "https://ets-videooutput-tst.s3.amazonaws.com/"
}

enum CategoryName: String, Codable {
    case babyshower = "Babyshower"
    case birthday = "Birthday"
    case wedding = "Wedding"
}

enum TypeEnum: String, Codable {
    case free = "free"
    case premium = "premium"
}
