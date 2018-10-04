//
//  EventListConstants.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/30/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit

class EventsLogHelper:NSObject {
    
    class var Instance: EventsLogHelper
    {
        struct staticStruct
        {
            static let instance = EventsLogHelper()
        }
        return staticStruct.instance;
    }
    
    func logRegistrationEvent(userId:String, emailId:String,
                              signUpMethod:String, country:String, city:String)
    {
        let appevents = ["userId": userId, "emailId": emailId, "signUpMethod": signUpMethod, "country": country, "city":city]
        FBSDKAppEvents.logEvent("iOS Registration", parameters: appevents)
    }
    
    func logTemplatePurchaseEvent(userId:String, emailId:String, templateId:String, price:String, discount:String, currency:String, country:String, city:String)
    {
        let appevents = ["userId": userId, "emailId": emailId, "templateId": templateId, "price": price, "discount": discount, "currency": currency, "country": country, "city":city]
        FBSDKAppEvents.logEvent("iOS Purchase", parameters: appevents)
    }
    
    func logTemplatePreviewEvent(userId:String, emailId:String, templateId:String, country:String, city:String)
    {
        let appevents = ["userId": userId, "emailId": emailId, "templateId": templateId, "country": country, "city":city, ]
        FBSDKAppEvents.logEvent("iOS Generate Preview", parameters: appevents)
    }
    
    func logTemplateFinalRenderEvent(userId:String, emailId:String, templateId:String, country:String, city:String)
    {
        let appevents = ["userId": userId, "emailId": emailId, "templateId": templateId, "country": country, "city":city, ]
        FBSDKAppEvents.logEvent("iOS Generate Final Video", parameters: appevents)
    }
    
    func logTemplateFinalRenderEvent(userId:String, emailId:String, videoUrl:String, country:String, city:String)
    {
        let appevents = ["userId": userId, "emailId": emailId, "videoUrl": videoUrl, "country": country, "city":city, ]
        FBSDKAppEvents.logEvent("iOS Download Video", parameters: appevents)
    }
}
