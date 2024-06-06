//
//  SM_LoginViewModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/23.
//

import UIKit

class SM_LoginViewModel: NSObject {
    static func getCurrentEnvironment(success: @escaping (SMDataModel) -> Void){
        let paramStr : String! = "wriggledup=" + SM_ShareFunction.getSomeWord() + "&" + "hesitation=" + SM_ShareFunction.getSomeWord()
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/riseLise", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getLoginVertifyCode(telNum : String,success: @escaping (SMDataModel) -> Void){
        let params = ["andlucy" : telNum ,"curtain" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/forkedFollowhalf", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func SMLogin(telNum : String,vertifyCode : String,success: @escaping (SMDataModel) -> Void){
        let params = ["theminto" : telNum ,"yards" : vertifyCode,"comeat" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/noRefil", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
}
