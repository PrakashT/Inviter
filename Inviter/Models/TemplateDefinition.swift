//
//  TemplateDefition.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/21/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import Foundation

struct TemplateDefinition: Codable {
    var resources: Resources
}

struct Resources: Codable {
    var texts: [Text]
    var images: [Image]
    let videos: [String]
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
    var s3Object, fileLocation: String
    let enableCropping: Bool
    let croppingShape, viewportWidth, viewportHeight, boundaryWidth: String
    let boundaryHeight: String
    
    enum CodingKeys: String, CodingKey {
        case type, inputType, index
        case s3Object = "s3object"
        case fileLocation, enableCropping, croppingShape, viewportWidth, viewportHeight, boundaryWidth, boundaryHeight
    }
    
    mutating func updateS3ObjectInfo(s3ObjectValue: String, fileLocationValue: String) {
        s3Object = s3ObjectValue;
        fileLocation = fileLocationValue
    }
}

struct Text: Codable {
    let type, inputType: InputTypeEnum
    let s3Object, fileLocation, key: String
    let maxLength: String?
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case type, inputType, maxLength
        case s3Object = "s3object"
        case fileLocation, key, value
    }
    
    mutating func updateTextValue(text: String) {
        value = text;
    }
}

enum InputTypeEnum: String, Codable {
    case text = "text"
    case textArea = "textArea"
}

