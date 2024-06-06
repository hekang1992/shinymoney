//
//  SMAppdelegate.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/23.
//

import UIKit
import Alamofire
import CoreLocation
import AppsFlyerLib
class SMAppdelegate: NSObject, UNUserNotificationCenterDelegate{
    var locationManager : CLLocationManager!
    var currentLocation : CLLocation?
    var hasLocated : Bool = false
    var cityLocationModel : SMCityLocationModel?
    @objc var currentNetworkUrl = "https://omdublending.com/"
    var netUrlsArr : [String] = []
    var currentNeturlIndex = 0
    var hasGetLocation : Bool = false
    var hasNetworkBlock : (() -> ())?
    func monitorNetwork(ifFirstEnter : Bool){
        let netManager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        netManager.startListening { status in
            if status == .reachable(.ethernetOrWiFi) || status == .reachable(.cellular) {
                if ifFirstEnter == true{
                    self.getCurrentEnvironment()
                    if SMUserModel.getSessionId()?.count ?? 0 > 0 {
                        self.startLocationAction()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self.surpriseInanything()
                    }
                    self.getAllCityLocationList()
                    self.hasNetworkBlock?()
                    
                    let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.ifFirstEnter = false
                }
            }
        }
    }
    
    func getCurrentEnvironment(){
        SM_LoginViewModel.getCurrentEnvironment { dataModel in
            if dataModel.onsinging == 0 {
                print("environment - %@",dataModel.ended as Any)
                let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let environmentModel : SMEnvironmentModel =  SMEnvironmentModel(jsondata: dataModel.ended!)
                SMUserModel.saveEnvironment(environmentStr: environmentModel.hasgone ?? "")
                appdelegate.goToHomeViewController()
                SMUserModel.checkIsLogin()
            }else {
                if self.netUrlsArr.count > 0 {
                    self.currentNeturlIndex = self.currentNeturlIndex + 1
                    if self.currentNeturlIndex < self.netUrlsArr.count {
                        self.currentNetworkUrl = self.netUrlsArr[self.currentNeturlIndex]
                        self.getCurrentEnvironment()
                    }
                }else{
                    SMNetAPI().getOtherNetUrlsList { ossUrlArr in
                        self.netUrlsArr = ossUrlArr
                        if self.netUrlsArr.count > 0 {
                            self.currentNeturlIndex = 0
                            self.currentNetworkUrl = self.netUrlsArr[self.currentNeturlIndex]
                            self.getCurrentEnvironment()
                        }
                    }
                }
                
            }
        }
    }
    
    
    func getAllCityLocationList(){
        if self.cityLocationModel == nil {
            SM_DataUploadViewModel.getAllCityLocationList { dataModel in
                if dataModel.onsinging == 0 {
                    self.cityLocationModel = SMCityLocationModel(jsondata: dataModel.ended!)
                }
            }
        }
    }
    
    func surpriseInanything(){  //google_market
        SM_DataUploadViewModel.surpriseInanything { dataModel in
            if dataModel.onsinging == 0 {
                let surpriseInanythingModel : SMGoogleUploadModel =  SMGoogleUploadModel(jsondata: dataModel.ended!)
                AppsFlyerLib.shared().appsFlyerDevKey = surpriseInanythingModel.softly ?? ""
                AppsFlyerLib.shared().appleAppID = surpriseInanythingModel.explainedmore ?? ""
                AppsFlyerLib.shared().start()
            }
        }
    }
    
    func startLocationAction(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func addAnalyticsPoint(productID : String,eventType : String,pride : String,thesleeping : String){
        let params = ["ofsome":productID,"basketand":eventType,"stirring":"","scratched":UIDevice.current.keychainIdfv,"quiteembarrassed":SM_ShareFunction.getDeviceIdfa(),"longer":String(self.currentLocation?.coordinate.longitude ?? 0),"mildly":String(self.currentLocation?.coordinate.latitude ?? 0),"pride":pride,"thesleeping":thesleeping,"philipagain":SM_ShareFunction.getSomeWord()]
        SM_DataUploadViewModel.addAnalyticsPoint(params: params) { dataModel in
            print("add point successfully - eventType : \(eventType)")
        }
    }
}

extension SMAppdelegate : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.notDetermined {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.hasGetLocation == false {
                self.hasGetLocation = true
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SMUPLOADDEVICEINFO"), object: nil)
            }
            
            let comeToLoingVCTime : String = UserDefaults.standard.object(forKey: "comeToLoingVCTime") as? String ?? ""
            let hasloginTime : String = UserDefaults.standard.object(forKey: "hasloginTime") as? String ?? ""
            if comeToLoingVCTime.count > 0 {
                self.addAnalyticsPoint(productID: "", eventType: "1", pride: comeToLoingVCTime, thesleeping: hasloginTime)
                UserDefaults.standard.set("", forKey: "comeToLoingVCTime")
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count == 0 {
            return
        }
        self.currentLocation = locations.first
        if self.hasLocated == false{
            if self.currentLocation != nil {
                self.uploadCurrentLocation(location: self.currentLocation!)
            }
        }
    }
    
    func uploadCurrentLocation(location : CLLocation){
        self.hasLocated = true
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if placemarks?.count == 0 {
                return
            }
            let placemark = placemarks?.first
            var params = ["ladiescoming":placemark?.administrativeArea ?? ""]
            params["thehotel"] = placemark?.isoCountryCode ?? ""
            params["distressed"] = placemark?.country ?? ""
            params["fromgoing"] = placemark?.name ?? ""
            params["mildly"] = String(placemark?.location?.coordinate.latitude ?? 0.0)
            params["longer"] = String(placemark?.location?.coordinate.longitude ?? 0.0)
            params["hemustn"] = placemark?.locality ?? ""
            params["everyonejumped"] = SM_ShareFunction.getSomeWord()
            params["peeped"] = SM_ShareFunction.getSomeWord()
            SM_DataUploadViewModel.garnishedwithDinah(params: params) { dataModel in
                print("I have uploaded the currentlocation - \(params)")
            }
            
            
        }
    }
}
