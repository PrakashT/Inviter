//
//  APIConstants.swift
//  Martins
//
//  Created by Enterpi iOS on 08/08/16.
//  Copyright © 2016 Enterpi iOS. All rights reserved.
//

import Foundation

class APIConstants
{
    // MARK: Base URL Constants
    
    //    let  TEST_ICON = "testicon.png"
    
    let IOS_CLIENT_ID = ""
    let IOS_CLIENT_SECRET = ""
    let BASE_HOST = ""
    
    // MARK: Link URL Constants in SETTINGS TAB - (FOR BOTH  PROD AND TESTING SAME)
     static let PRIVACY_POLICY_LINK = "https://inviter.com/privacypolicy"
     static let ABOUT_US_LINK = "https://inviter.com/aboutus"
     static let TERMS_AND_SERVICES_LINK = "https://inviter.com/termsofservices"
     static let CONTACT_US_LINK = "https://inviter.com/contactus"
    
     static let DUMMY_PROFILE_PATH = "https://inviter.com/public/images/user-dummy.jpg"
    
    // MARK: API Function Constants
    static let countryCode = (NSLocale.current.regionCode == "US") ? "US" : "IN"

    static let CREATE_USER = MA_BASE_URL_PHP+"app/signup"
    static let CHECK_MAIL = MA_BASE_URL_PHP+"user/checkEmail/"
    static let USER_LOGIN = MA_BASE_URL_PHP+"signin/doSignIn"
    static let GET_USER_DETAILS = MA_BASE_URL_PHP+"user/getuserdata/"
    static let FORGOT_PASSWORD_URL = MA_BASE_URL_PHP+"/forgotpassword";

    static let GET_CATEGORIES = MA_API_BASE_HOST+"aemen/api/rest/new/categories/"
    static let GET_CATEGORIES_GENERIC = GET_CATEGORIES+"?generic=generic&country="+countryCode
    static let GET_CATEGORIES_SPECIFIC = GET_CATEGORIES+"?generic=specific&country="+countryCode

    static let GET_TEMPLATES_BY_CATEGORY = MA_API_BASE_HOST+"/aemen/api/rest/new/template/?country="+countryCode+"&category="
    static let GET_TEMPLATES = MA_API_BASE_HOST+"aemen/api/rest/new/template/?country="+countryCode
    static let GET_MYVIDEOS = MA_API_BASE_HOST+"aemen/api/rest/new/myvideos/"
    
    static let GET_TEMPLATEBYID = MA_API_BASE_HOST + "/aemen/api/rest/new/template/?id=1"
    static let GET_CHECK_RENDERER_STATUS = MA_API_BASE_HOST+"aemen/api/render/status/<uuid:taskid>/"
    static let GET_RENDERER_STATUS = MA_API_BASE_HOST+"aemen/api/render/status/"

    static let POST_MEDIA_DATA = MA_API_BASE_HOST+"aemen/api/rest/new/assetupload/"
    static let POST_START_RENDERER_PROCESS = MA_API_BASE_HOST+"aemen/api/render/initrender/?final_video="
    static let POST_START_RENDERER_PROCESS_FINAL = POST_START_RENDERER_PROCESS+"?final_video="
    static let POST_CREATE_OR_UPDATE_DEVICE_TOKEN = MA_API_BASE_HOST+"aemen/api/rest/new/devicetoken/"
    static let POST_DELETE_MyVIDEOS = MA_API_BASE_HOST+"/aemen/api/rest/new/myvideos/delete?id="

    // MARK: API HOST Constants
//    #if DEVELOPMENT
    static let MA_API_BASE_HOST = MA_BASE_URL //+ "api/v1/"
    static let MA_BASE_URL = "http://testing.inviter.com/"
    static let MA_BASE_URL_PHP = "http://testing.inviter.com/"
    static let S3_BASE_URL = "https://ets-videooutput-tst.s3.amazonaws.com/"
//    #else
//    static let MA_API_BASE_HOST = MA_BASE_URL //+ "api/v1/"
//    static let MA_BASE_URL = "http://taskresults.inwiter.com/"
//    static let MA_BASE_URL_PHP = "https://inviter.com/"
//    static let S3_BASE_URL = "https://d1bdry3axpowl5.cloudfront.net/"
//    #endif

}

