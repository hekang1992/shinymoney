//
//  SM_AccountViewModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/11.
//

import UIKit

class SM_AccountViewModel: NSObject {
    static func logout(success: @escaping (SMDataModel) -> Void){
        let paramStr : String! = "lookedround=" + SM_ShareFunction.getSomeWord() + "&" + "noticing=" + SM_ShareFunction.getSomeWord()
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/andShe", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { dataModel in
            success(dataModel)
        }
    }
    
    static func deleteAccount(success: @escaping (SMDataModel) -> Void){
        let paramStr : String! = "thetime=" + SM_ShareFunction.getSomeWord()
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/droppingPresent", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { dataModel in
            success(dataModel)
        }
    }
}
