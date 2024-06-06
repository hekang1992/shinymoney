//
//  SMUserModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/23.
//

import UIKit
import SwiftyJSON
class SMUserModel: NSObject,NSCoding{
    var theremight : String?  //sessionId
    @objc var theminto : String?    //phoneNumber
    var uid : String?
    
    init(jsondata: JSON){
        theremight = jsondata["theremight"].stringValue
        theminto = jsondata["theminto"].stringValue
        uid = jsondata["uid"].stringValue
    }
    
    required init?(coder: NSCoder) {
        self.theremight = coder.decodeObject(forKey: "theremight") as? String
        self.theminto = coder.decodeObject(forKey: "theminto") as? String
        self.uid = coder.decodeObject(forKey: "uid") as? String
        super.init()
    }
    
     func encode(with coder: NSCoder) {
        coder.encode(theremight, forKey: "theremight")
        coder.encode(theminto, forKey: "theminto")
        coder.encode(uid, forKey: "uid")
    }
    
    static func saveUser(user : SMUserModel) {
        let userDefaults = UserDefaults.standard
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false) {
            print("Archived data: \(data)")
            userDefaults.set(data, forKey: "SMUserModel")
        } else {
            print("Error archiving data.")
        }
        userDefaults.synchronize()
        
        SMUserModel.saveSessionId(sessionId: user.theremight ?? nil)
    }
     
   @objc static func getUser() -> SMUserModel?{
        if let userDefaultsData = UserDefaults.standard.object(forKey: "SMUserModel") {
            if let user = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userDefaultsData as! Data) as? SMUserModel {
                return user
            }
        }
        return nil
    }
    
    static func saveSessionId(sessionId : String?){
        let userDefaults = UserDefaults.standard
        userDefaults.set(sessionId, forKey: "SMSessionId")
    }
    
    @objc static func getSessionId() -> String?{
        let userDefaults = UserDefaults.standard
        let sessionId = userDefaults.object(forKey: "SMSessionId")
        return sessionId as? String
    }
    
    static func cancelLogin(){
        let user : SMUserModel = SMUserModel(jsondata: [:])
        SMUserModel.saveUser(user: user)
        
        SMUserModel.saveSessionId(sessionId: nil)
    }
    
    static func saveEnvironment(environmentStr : String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(environmentStr, forKey: "SMEnvironment")
    }
    
    static func getEnvironment() -> String?{
        let userDefaults = UserDefaults.standard
        let environmentStr = userDefaults.object(forKey: "SMEnvironment")
        return environmentStr as? String
    }
    
    @objc static func ISLOGIN() -> Bool{
        if SMUserModel.getSessionId() == nil{
           return false
        }else{
           return true
        }
    }
    
    @objc static func checkIsLogin() -> Bool{
        if SMUserModel.ISLOGIN() == false {
            let currentTopVC = UIViewController.getCurrentViewController()
            if currentTopVC?.isKind(of: SM_LoginVC.self) == true {
                return false
            }
            let loginVC : SM_NavigationViewController = SM_NavigationViewController(rootViewController:SM_LoginVC())
            loginVC.modalPresentationStyle = .fullScreen
            UIViewController.getCurrentViewController()?.present(loginVC, animated: true)
            return false
        }
        return true
    }
}
