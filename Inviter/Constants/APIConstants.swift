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
    
    // MARK: Link URL Constants in You TAB
    
    // MARK: API Function Constants
    static let countryCode = (NSLocale.current.regionCode == "US") ? "US" : "IN"

    static let CREATE_USER = MA_API_BASE_HOST+"app/signup"
    static let CHECK_MAIL = MA_API_BASE_HOST+"user/checkEmail/"
    static let USER_LOGIN = MA_API_BASE_HOST+"signin/doSignIn"
    static let GET_USER_DETAILS = MA_API_BASE_HOST+"user/getuserdata/" // TODO: CHANGE IT TO ONSTANTSÍ

    static let GET_CATEGORIES = MA_API_BASE_HOST+"aemen/api/rest/new/categories/"
    static let GET_CATEGORIES_GENERIC = GET_CATEGORIES+"?generic=generic"
    static let GET_CATEGORIES_SPECIFIC = GET_CATEGORIES+"?generic=specific"

    static let GET_TEMPLATES = MA_API_BASE_HOST+"aemen/api/rest/new/template/?country="+countryCode
    static let GET_MYVIDEOS = MA_API_BASE_HOST+"aemen/api/rest/new/myvideos/?country="+countryCode
    static let GET_TEMPLATEBYID = MA_API_BASE_HOST + "/aemen/api/rest/new/template/?id=1"
    static let GET_CHECK_RENDERER_STATUS = MA_API_BASE_HOST+"aemen/api/render/status/<uuid:taskid>/"

    static let POST_MEDIA_DATA = MA_API_BASE_HOST+"aemen/api/rest/new/assetupload/"
     static let POST_START_RENDERER_PROCESS = MA_API_BASE_HOST+"aemen/api/render/initrender/?final_video="
    static let POST_START_RENDERER_PROCESS_FINAL = POST_START_RENDERER_PROCESS+"?final_video="

//    static let UPDATE_USER_DETAILS = MA_API_BASE_HOST+"updateuser.php?"
//    static let FORGOT_USER_PASSWORD = MA_API_BASE_HOST+"forgotpassword.php?phone="
    
    //    http://1indya.com/forgotpassword.php?phone=
 //    "http://1indya.com/insert_user.php?username=narendra&email=naren.darla@gmail.com&password=narendra&city=hyderabad&active=true&phone=70495602661"

//    http://1indya.com/updateuser.php?username=JAYA&email=naren.darla@gmail.com&password=narendra&city=hyderabad&active=true&phone=7049560282
    
    // MARK: API HOST Constants
    //    #if DEVELOPMENT
    static let MA_API_BASE_HOST = MA_BASE_URL //+ "api/v1/"
    static let MA_BASE_URL = "http://testing.inviter.com/"
    static let S3_BASE_URL = "https://ets-videooutput-tst.s3.amazonaws.com/"
    
    //    #if PROD
//    static let S3_BASE_URL = "https://d1bdry3axpowl5.cloudfront.net/";
}
