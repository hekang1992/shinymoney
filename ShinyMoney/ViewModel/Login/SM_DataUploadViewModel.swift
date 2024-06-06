//
//  SM_DataUploadViewModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/24.
//

import UIKit

class SM_DataUploadViewModel: NSObject {
    static func surpriseInanything(success: @escaping (SMDataModel) -> Void){
        let params : [String:Any] = ["belonged":UIDevice.current.keychainIdfv,"hewas":SM_ShareFunction.getSomeWord(),"belonghim":SM_ShareFunction.getDeviceIdfa()]
        print("google-market upload params = %@",params)
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/surpriseInanything", paramsDictionary: params, ifShowError: false, ifShowStyle: false) { dataModel in
            success(dataModel)
        }
    }
    
    static func garnishedwithDinah(params : [String : String],success: @escaping (SMDataModel) -> Void){
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/garnishedwithDinah", paramsDictionary: params, ifShowError: false, ifShowStyle: false) { dataModel in
            success(dataModel)
        }
    }
    
    static func addAnalyticsPoint(params : [String : String],success: @escaping (SMDataModel) -> Void){
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/dinah", paramsDictionary: params, ifShowError: false, ifShowStyle: false) { dataModel in
            success(dataModel)
        }
    }
    
    static func getAllCityLocationList(success: @escaping (SMDataModel) -> Void){
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/bigmisterOnget", paramsString: "", ifShowError: false, ifShowStyle: false) { dataModel in
            success(dataModel)
        }
    }
}
