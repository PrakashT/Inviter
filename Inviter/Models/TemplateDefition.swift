//
//  TemplateDefition.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/21/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

import Foundation

struct Templates: Codable {
    let resources: Resources
}

struct Resources: Codable {
    let texts: [Text]
    let images: [Image]
    let videos: [JSONAny]
    let audios: Audios
}

struct Audios: Codable {
    let type, inputType: String
    let index: Int
    let s3Object, fileLocation: String
    
    enum CodingKeys: String, CodingKey {
        case type, inputType, index
        case s3Object = "s3object"
        case fileLocation
    }
}

struct Image: Codable {
    let type, inputType: String
    let index: Int
    let s3Object, fileLocation: String
    let enableCropping: Bool
    let croppingShape, viewportWidth, viewportHeight, boundaryWidth: String
    let boundaryHeight: String
    
    enum CodingKeys: String, CodingKey {
        case type, inputType, index
        case s3Object = "s3object"
        case fileLocation, enableCropping, croppingShape, viewportWidth, viewportHeight, boundaryWidth, boundaryHeight
    }
}

struct Text: Codable {
    let type, inputType: InputTypeEnum
    let s3Object, fileLocation, key, value: String
    
    enum CodingKeys: String, CodingKey {
        case type, inputType
        case s3Object = "s3object"
        case fileLocation, key, value
    }
}

enum InputTypeEnum: String, Codable {
    case text = "text"
}
