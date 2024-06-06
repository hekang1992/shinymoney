//
//  SM_HomeViewModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/26.
//

import UIKit

class SM_HomeViewModel: NSObject {
    static func getHomeInfomationListData(success: @escaping (SMDataModel) -> Void){
        let paramStr : String! = "wriggledup=" + SM_ShareFunction.getSomeWord() + "&" + "hesitation=" + SM_ShareFunction.getSomeWord()
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/right", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { dataModel in
            success(dataModel)
        }
    }
    
    static func applyProduct(local:String, success: @escaping (SMDataModel) -> Void){
        let params = ["local" : local ,"refreshed" : SM_ShareFunction.getSomeWord(),"proudly" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/engineRemembered", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getProductDetail(local:String, success: @escaping (SMDataModel) -> Void) {
        let params = ["local" : local ,"yesterday" : SM_ShareFunction.getSomeWord(),"ullabaid" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/soClick", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getUserCardIdentifyData(local:String,success: @escaping (SMDataModel) -> Void){
        let paramStr : String! = "local=" + local + "&" + "thosephotographs=" + SM_ShareFunction.getSomeWord()
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/noLooked", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getFaceRegAdvanceCount(success: @escaping (SMDataModel) -> Void) {
        let params = ["himselfoverboard" : SM_ShareFunction.getSomeWord() ,"ending" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/everyoneSlipping", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func uploadImageToSever(image : UIImage, happen : String,local : String,bigboy : String,protesting : String,waddling : String, indisdain : String,isextremely : String, success: @escaping (SMDataModel) -> Void) {
        let params = ["happen" : happen ,"local" : local,"bigboy" : bigboy,"waddling" : waddling,"indisdain" : indisdain,"isextremely" : isextremely]
        SMNetAPI.sharedInstance.uploadImageAPI(urlPath: "/shimo/rightStrange", paramsDic: params, image: image, imageName: protesting, ifShowError: true, ifShowStyle: true) { dataModel in
           success(dataModel)
        }
    }
    
    static func saveCardInfo(birth : String, abedroom : String,successful : String,bigboy : String,isextremely : String, success: @escaping (SMDataModel) -> Void) {
        let params = ["hethinks" : birth ,"abedroom" : abedroom,"successful" : successful,"bigboy" : bigboy,"isextremely" : isextremely]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/attemptAbout", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getStep02Info(local : String, success: @escaping (SMDataModel) -> Void) {
        let params = ["local" : local]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/proudGloat", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func saveStep02Info(params : [String : String], success: @escaping (SMDataModel) -> Void) {
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/interestCalled", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getStep03Info(local : String, success: @escaping (SMDataModel) -> Void) {
        let params = ["local" : local]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/philipWhitewashed", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func saveStep03Info(params : [String : String], success: @escaping (SMDataModel) -> Void) {
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/askedPresent", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getStep04Info(local : String, success: @escaping (SMDataModel) -> Void) {
        let params = ["local" : local,"takesa" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/dangerousAnimals", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func saveStep04Info(params : [String : String], success: @escaping (SMDataModel) -> Void) {
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/oolaLaughter", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getStep05Info(success: @escaping (SMDataModel) -> Void) {
        let paramStr : String! = "likethat=" + "0" + "&" + "relative=" + SM_ShareFunction.getSomeWord()
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/climbedLeapt", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { dataModel in
            success(dataModel)
        }
    }
    
    static func saveStep05Info(params : [String : String], success: @escaping (SMDataModel) -> Void) {
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/aboutHalfnaked", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getOrderUrl(orderNo : String ,success: @escaping (SMDataModel) -> Void) {
        let params = ["alarmed" : orderNo,"become" : SM_ShareFunction.getSomeWord(),"charming" : SM_ShareFunction.getSomeWord(),"hadgone" : SM_ShareFunction.getSomeWord(),"father" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/threeCalled", paramsDictionary:params , ifShowError: true, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func homeUploadDeviceInfo(ended : String, success: @escaping (SMDataModel) -> Void) {
        let params = ["ended" : ended]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/quietRunning", paramsDictionary:params , ifShowError: false, ifShowStyle:false) { dataModel in
            success(dataModel)
        }
    }
    
    static func uploadNotificationToken(crazy : String , success: @escaping (SMDataModel) -> Void) {
        let params = ["crazy" : crazy]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/looseChildren", paramsDictionary:params , ifShowError: false, ifShowStyle:false) { dataModel in
            success(dataModel)
        }
    }
    
    static func getOrderList(known : String , success: @escaping (SMDataModel) -> Void) {
        let params = ["known" : known]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/movingCackle", paramsDictionary:params , ifShowError: false, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
    
    static func getLoanList(success: @escaping (SMDataModel) -> Void) {
        let paramStr : String! = "wriggledup=" + SM_ShareFunction.getSomeWord() + "&" + "hesitation=" + SM_ShareFunction.getSomeWord()
        SMNetAPI.sharedInstance.requestGetAPI(urlPath: "/shimo/adventureChild", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { dataModel in
            success(dataModel)
        }
    }
    
    static func mattressAbroad(local : String, success: @escaping (SMDataModel) -> Void) {
        let params = ["local" : local,"refreshed" : SM_ShareFunction.getSomeWord(),"proudly" : SM_ShareFunction.getSomeWord()]
        SMNetAPI.sharedInstance.requestPostAPI(urlPath: "/shimo/mattressAbroad", paramsDictionary:params , ifShowError: false, ifShowStyle:true) { dataModel in
            success(dataModel)
        }
    }
}
