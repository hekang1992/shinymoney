//
//  LendEasy_NetAPI.swift
//  LendEasyProject
//
//  Created by Apple on 2023/9/18.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
class SMNetAPI: NSObject {
    var activityIndicator:UIActivityIndicatorView!
    static let sharedInstance = SMNetAPI()
    func requestPostAPI(urlPath : String, paramsDictionary : [String:Any]?, ifShowError : Bool, ifShowStyle : Bool,block : @escaping (SMDataModel) -> Void){
        
        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                print("Please check network permissions")
//                SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please check network permissions")
                return
            }
        }
        
        if ifShowStyle == true {
            SMCustomActivityIndicatorView.showActivityInWindow(messageStr: "Loading")
        }
        
        AF.session.configuration.timeoutIntervalForRequest = 18
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data"
        ]
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var wholeUrlPath = appdelegate.smAppdelegate.currentNetworkUrl + "/mons" + urlPath + "?" + SM_ShareFunction.getAPIParamWord()
        wholeUrlPath = wholeUrlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        AF.request(wholeUrlPath, method: HTTPMethod.post,parameters:paramsDictionary,headers: headers).responseDecodable {(response:DataResponse<JSON, AFError>) in
            if ifShowStyle == true {
                SMCustomActivityIndicatorView.dismissActivityView()
            }
            
            if response.data == nil {
                print("no data")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: response.data!,options:[.mutableContainers,.mutableLeaves,.fragmentsAllowed])
            let jsonDic = JSON.init(json as Any)
//            if urlPath != "/shimo/bigmisterOnget" {
                print("url --- \(urlPath)\ndata ----- \n\(String(describing: jsonDic))")
//            }
            
            let model =  SMDataModel(jsondata: jsonDic)
            if model.onsinging == 0 {
                block(model)
            }else{
                if model.onsinging == -2 {
                    SMUserModel.cancelLogin()
                    if SMUserModel.checkIsLogin() == false {
                        return
                    }
                }else {
                    if ifShowError == true {
                        SMCustomActivityIndicatorView.showErrorProcessView(errorStr: model.heardhalf!)
                    }
                }
                block(model)
           }
        }
    }
    
    func requestGetAPI(urlPath : String, paramsString : String?, ifShowError : Bool, ifShowStyle : Bool,block : @escaping (SMDataModel) -> Void){

        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
//                SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please check network permissions")
                return
            }
        }
        
        if ifShowStyle == true {
            SMCustomActivityIndicatorView.showActivityInWindow(messageStr: "Loading")
        }
        
        AF.session.configuration.timeoutIntervalForRequest = 18
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data"
        ]
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var wholeUrlPath = appdelegate.smAppdelegate.currentNetworkUrl + "/mons" + urlPath + "?" + SM_ShareFunction.getAPIParamWord()
        if paramsString!.count > 0 {
            wholeUrlPath = wholeUrlPath + "&" + paramsString!
        }
        wholeUrlPath = wholeUrlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        AF.request(wholeUrlPath, method:HTTPMethod.get, parameters:nil, headers:headers).responseDecodable {(response:DataResponse<JSON, AFError>) in
            
            if ifShowStyle == true {
                SMCustomActivityIndicatorView.dismissActivityView()
            }
        
            if response.data == nil || response.error != nil{
                print("no data")
                
                if urlPath == "/shimo/riseLise" {
                    let jsonData = ["onsinging" : "-9999","heardhalf" : ""]
                    let jsonDic = JSON.init(jsonData as Any)
                    let model =  SMDataModel(jsondata: jsonDic)
                    print("******* %ld",model.onsinging as Any)
                    block(model)
                }
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: response.data!,options:[.mutableContainers,.mutableLeaves,.fragmentsAllowed])
            let jsonDic = JSON.init(json as Any)
            print("url --- \(urlPath)\ndata ----- \n\(String(describing: jsonDic))")

            let model =  SMDataModel(jsondata: jsonDic)
            
            if model.onsinging == 0 {
                block(model)
            }else{
                if model.onsinging == -2 {
                    SMUserModel.cancelLogin()
                    if SMUserModel.checkIsLogin() == false {
                        return
                    }
                }else {
                    if ifShowError == true {
                        SMCustomActivityIndicatorView.showErrorProcessView(errorStr: model.heardhalf!)
                    }
                }
                block(model)
            }
        }
    }
    
    func uploadImageAPI(urlPath : String, paramsDic : [String:Any]?, image : UIImage, imageName : String, ifShowError : Bool, ifShowStyle : Bool, block :@escaping (SMDataModel) -> Void){

        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
//                SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please check network permissions")
                return
            }
        }
        
        if ifShowStyle == true {
            SMCustomActivityIndicatorView.showActivityInWindow(messageStr: "Loading")
        }
        
        AF.session.configuration.timeoutIntervalForRequest = 18
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data",
        ]
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var wholeUrlPath = appdelegate.smAppdelegate.currentNetworkUrl + "/mons" + urlPath + "?" + SM_ShareFunction.getAPIParamWord()
        wholeUrlPath = wholeUrlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        AF.upload(multipartFormData: { multipartFormData in
            let data : Data = image.jpegData(compressionQuality: 0.2) ?? Data()
            multipartFormData.append(data, withName: imageName,fileName: imageName + ".png",mimeType: "image/png")
            for param in paramsDic! {
                let value : String! = param.value as? String
                multipartFormData.append((value.data(using: .utf8))!, withName: param.key)
            }
        }, to: wholeUrlPath, method: .post,headers: headers).uploadProgress { progress in
            print("upload success")
        }.responseDecodable {(response:DataResponse<JSON, AFError>) in
            if ifShowStyle == true {
                SMCustomActivityIndicatorView.dismissActivityView()
            }
            if response.error != nil {
                print("error --- \(response.error.debugDescription)")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: response.data!,options:[.mutableContainers,.mutableLeaves,.fragmentsAllowed])
            let jsonDic = JSON.init(json as Any)
            print("url --- \(urlPath)\ndata ----- \n\(String(describing: jsonDic))")

            let model =  SMDataModel(jsondata: jsonDic)
            if model.onsinging == 0 {
                block(model)
            }else{
                if model.onsinging == -2 {
                    SMUserModel.cancelLogin()
                    if SMUserModel.checkIsLogin() == false {
                        return
                    }
                }else {
                    if ifShowError == true {
                        SMCustomActivityIndicatorView.showErrorProcessView(errorStr: model.heardhalf!)
                    }
                }
                block(model)
            }
        }
    }
    
    func getOtherNetUrlsList(block :@escaping ([String]) -> Void){
        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                return
            }
        }
        
        AF.session.configuration.timeoutIntervalForRequest = 18
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data"
        ]
        
        let wholeUrlPath = "https://raw.githubusercontent.com/dtsdark/zeew/main/wwr"
        AF.request(wholeUrlPath, method:HTTPMethod.get, parameters:nil, headers:headers).responseDecodable {(response:DataResponse<JSON, AFError>) in
            if response.data == nil {
                print("no data")
                return
            }
            
            if let responseData = response.data {
                if let resultData = Data(base64Encoded: responseData, options: .ignoreUnknownCharacters) {
                    if let dataString = String(data: resultData, encoding: .utf8) {
                        if let resultData = dataString.data(using: .utf8) {
                            do {
                                if let ossUrlsArr = try JSONSerialization.jsonObject(with: resultData, options: .mutableContainers) as? [String] {
                                    block(ossUrlsArr)
                                }
                            } catch {
                                
                            }
                        }
                    }
                }
            }
        }
    }
}
