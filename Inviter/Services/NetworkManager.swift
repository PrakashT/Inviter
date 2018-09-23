//
//  NetworkManager.swift
//  SwiftApp
//
//  Created by Enterpi iOS on 02/08/16.
//  Copyright © 2016 Enterpi iOS. All rights reserved.
//

import UIKit
import Foundation

import Alamofire

import SwiftyJSON

//import Firebase

// MARK: Alamofire Extensions

enum JSONValue
{
    case jNumber(NSNumber)
    case jString(String)
    case jBool(Bool)
    case jNull
    case jArray(Array<JSONValue>)
    case jObject(Dictionary<String,JSONValue>)
    case jInvalid(NSError)
}

enum DownloadImageType
{
    case site
    case userProfile
}

typealias AlamofireResponseCompletionBlock = (URLRequest, HTTPURLResponse?, AnyObject?, NSError?) -> Void

typealias APIResourceResponseCompletionBlock = (URLRequest, HTTPURLResponse?, JSONValue?, NSError?) -> Void
typealias APICollectionResponseCompletionBlock = (URLRequest, HTTPURLResponse?, [JSONValue]?, Int?, NSError?) -> Void

class NetworkManager: NSObject
{
    class var Instance: NetworkManager
    {
        struct staticStruct
        {
            static let instance = NetworkManager()
        }
        return staticStruct.instance;
    }
    
    // MARK: User Creation / Updation / Check User n Email Existance / ChnagePassword / GetUserInfo APIs
    func postRequestData(_ parameters:  String, headerParameters: Dictionary<String, String>, url:String, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        print(#function+"LINK:", url)
        print(#function+"parameters::::", parameters)
        print(#function+"headerParameters::::", headerParameters)
//
//             Alamofire.request( APIConstants.USER_LOGIN , method: .post, parameters:parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response -> Void in
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(headerParameters["Authorization"]!, forHTTPHeaderField: "Authorization")

//        let pjson = attendences.toJSONString(prettyPrint: false)
        let data = (parameters.data(using: .utf8))! as Data
        
        request.httpBody = data
        
        Alamofire.request(request).responseJSON { (response) in
            
            print(response)
            
            switch response.result
            {
            case .success(let data):
                let swiftyJsonVar = JSON(data)
                
                print(#function+"Success :")
                
                withCompletionHandler(swiftyJsonVar)
                
            case .failure(let error):
                print("Request failed with error: \(error) response:", response)
                withCompletionHandler(nil)
            }

            
        }
        
//        Alamofire.request(url, method: .post, parameters:parameters ,encoding: URLEncoding.queryString, headers:Auth_header).responseJSON(completionHandler: { response -> Void in
//
//            print(#function+"response ::::---  :", response, "STATUS CODE:", response.response?.statusCode)
//
//            guard let arrayData = response.value else{
//
//                //                FirebaseCrashMessage("creatMA_BASE_URLMA_BASE_URLeNewUser"+response.description)
//                withCompletionHandler(nil)
//
//                return
//            }
//
//            switch response.result
//            {
//            case .success(let data):
//                let swiftyJsonVar = JSON(data)
//
//                print(#function+"Success :")
//
//                withCompletionHandler(swiftyJsonVar)
//
//            case .failure(let error):
//                print("Request failed with error: \(error) response:", response)
//                withCompletionHandler(nil)
//            }
//        })
    }
    
    func uploadImage(_ imgData:Data, header: Dictionary<String, String>, url:String, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        print(#function+"LINK:", url)
        print(#function+"header::::", header)
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(imgData, withName: "file", fileName: "sample.png", mimeType: "image/png")},
//                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers:header, //["Authorization": "Token 4CFxGuZ8IN6M250D"],
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.uploadProgress(closure: { (progress) in
                                    print("Upload Progress: \(progress.fractionCompleted)")
                                })
                                
                                upload.responseJSON { response in
                                    print("responseJSON:", response, response.result.value)
                                    switch response.result
                                    {
                                    case .success(let data):
                                        let swiftyJsonVar = JSON(data)                                        
                                        print(#function+"Success :")
                                        withCompletionHandler(swiftyJsonVar)
                                        
                                    case .failure(let error):
                                        print("Request failed with error: \(error) response:", response)
                                        withCompletionHandler(nil)
                                    }
                                }

                            case .failure(let encodingError):
                                print(encodingError)
                                withCompletionHandler(nil)
                            }
        })
    }
    
    func createNewUser(_ parameters: Dictionary<String, String>, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        print(#function+"LINK:", APIConstants.CREATE_USER)
        print(#function+"parameters::::", parameters)
        
        Alamofire.request( APIConstants.CREATE_USER , method: .post, parameters:parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response -> Void in

            print(#function+"response ::::---  :", response)

            guard let arrayData = response.value else{

//                FirebaseCrashMessage("creatMA_BASE_URLMA_BASE_URLeNewUser"+response.description)
                withCompletionHandler(nil)

                return
            }

            switch response.result
            {
            case .success(let data):
                let swiftyJsonVar = JSON(data)

                print(#function+"Success :")

                withCompletionHandler(swiftyJsonVar)

            case .failure(let error):
                print("Request failed with error: \(error) response:", response)
                withCompletionHandler(nil)
            }
        })
    }
    
    func checkUserExistence(_ parameters: Dictionary<String, String>, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        print(#function+"LINK:", APIConstants.CHECK_MAIL)
        print(#function+"parameters:", parameters)

//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            // 送信データを設定
//
////            multipartFormData.append(dataA, withName: "dataA", mimeType: "text/plain")
////            multipartFormData.append(dataB, withName: "dataB", mimeType: "text/plain")
////            multipartFormData.append(dataC, withName: "dataC", fileName: "send.png", mimeType: "image/png")
//        }, to: APIConstants.CHECK_MAIL+mailID) { (encodingResult) in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in // ← JSON形式で受け取る
//                    if !response.result.isSuccess {
//                        print("# ERROR")
//                    } else {
//                        print("# SUCCESS")
//                        print(response)
//                    }
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//        }
        
        Alamofire.request(APIConstants.CHECK_MAIL , method:HTTPMethod.post, parameters:parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response -> Void in

            print(#function+"response ::::---  :", response)

//            guard let arrayData = response.value else{
//
////                FirebaseCrashMessage("checkUserExistence"+response.description)
//                withCompletionHandler(nil)
//
//                return
//            }

            switch response.result
            {
            case .success(let data):
                let swiftyJsonVar = JSON(data)

                print(#function+"Success")

                withCompletionHandler(swiftyJsonVar)

            case .failure(let error):
                print("Request failed with error: \(error)")
                withCompletionHandler(nil)
            }
        })
    }
    
    func getUserDetails(_ userID: String, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        print(#function+"LINK:", APIConstants.GET_USER_DETAILS+userID)
        
        Alamofire.request( APIConstants.GET_USER_DETAILS+userID , method: .get).responseJSON(completionHandler: { response -> Void in
            
            print(#function+"response ::::---  :", response)
            
            guard let arrayData = response.value else{
                
                //                FirebaseCrashMessage("creatMA_BASE_URLMA_BASE_URLeNewUser"+response.description)
                withCompletionHandler(nil)
                
                return
            }
            
            switch response.result
            {
            case .success(let data):
                let swiftyJsonVar = JSON(data)
                
                print(#function+"Success :")
                
                withCompletionHandler(swiftyJsonVar)
                
            case .failure(let error):
                print("Request failed with error: \(error) response:", response)
                withCompletionHandler(nil)
            }
        })
    }
    
    func getCategories(type:CategoryType, userAuthParameters: Dictionary<String, String>, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        var url = APIConstants.GET_CATEGORIES_GENERIC
        if(type == .Specific)
        {
            url = APIConstants.GET_CATEGORIES_SPECIFIC
        }
        print(#function+"LINK:", url)

        Alamofire.request(url , method: .get, headers: userAuthParameters).responseJSON(completionHandler: { response -> Void in
            
            print(#function+"response ::::---  :", response)
            
            guard let arrayData = response.value else{
                //                FirebaseCrashMessage("creatMA_BASE_URLMA_BASE_URLeNewUser"+response.description)
                withCompletionHandler(nil)
                
                return
            }
            
            switch response.result
            {
            case .success(let data):
                let swiftyJsonVar = JSON(data)
                
                print(#function+"Success :")
                
                withCompletionHandler(swiftyJsonVar)
                
            case .failure(let error):
                print("Request failed with error: \(error) response:", response)
                withCompletionHandler(nil)
            }
        })
    }
    
    func getTemplates(_ userAuthParameters: Dictionary<String, String>, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        print(#function+"LINK:", APIConstants.GET_TEMPLATES)
        
        Alamofire.request( APIConstants.GET_TEMPLATES , method: .get, headers: userAuthParameters).responseJSON(completionHandler: { response -> Void in
            
            print(#function+"response ::::---  :", response)
            
            guard let arrayData = response.value else{
                //                FirebaseCrashMessage("creatMA_BASE_URLMA_BASE_URLeNewUser"+response.description)
                withCompletionHandler(nil)
                
                return
            }
            
            switch response.result
            {
            case .success(let data):
                let swiftyJsonVar = JSON(data)
                
                print(#function+"Success :")
                
                withCompletionHandler(swiftyJsonVar)
                
            case .failure(let error):
                print("Request failed with error: \(error) response:", response)
                withCompletionHandler(nil)
            }
        })
    }
    
    func userLogin(_ parameters: Dictionary<String, String>, withCompletionHandler:@escaping (_ result:JSON) -> Void)
    {
        print(#function+"LINK:", APIConstants.USER_LOGIN)
        print(#function+"parameters::::", parameters)
        
        Alamofire.request( APIConstants.USER_LOGIN , method: .post, parameters:parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response -> Void in
            
            print(#function+"response ::::---  :", response)
            
            guard let arrayData = response.value else{
                
                //                FirebaseCrashMessage("creatMA_BASE_URLMA_BASE_URLeNewUser"+response.description)
                withCompletionHandler(nil)
                
                return
            }
            
            switch response.result
            {
            case .success(let data):
                let swiftyJsonVar = JSON(data)
                
                print(#function+"Success :")
                
                withCompletionHandler(swiftyJsonVar)
                
            case .failure(let error):
                print("Request failed with error: \(error) response:", response)
                withCompletionHandler(nil)
            }
        })
    }
}
