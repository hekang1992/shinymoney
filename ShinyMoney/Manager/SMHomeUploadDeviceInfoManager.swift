//
//  SMHomeUploadDeviceInfoManager.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/6.
//

import UIKit

class SMHomeUploadDeviceInfoManager: NSObject {
     func uploadDeviceInfoToServe(){
        UIDevice.current.isBatteryMonitoringEnabled = true
         var pleased : String = "0"
         if UIDevice.current.batteryState == UIDevice.BatteryState.charging {
             pleased = "1"
         }
        let timezone : String = NSTimeZone.system.abbreviation() ?? ""
        let loginTime : String = UserDefaults.standard.value(forKey: "hasloginTime") as? String ?? ""
        
        var paramDic = ["quarters":"ios","towake":UIDevice.current.systemVersion,"fiercely":loginTime ,"defend":(Bundle.main.bundleIdentifier ?? ""),"planning":["prepared":String(format: "%.0f", UIDevice.current.batteryLevel*100),"andnow":pleased]] as [String : Any]
        
         let wifiInfo : Dictionary = SMDeviceInfoTool().sm_fetchSSIDInfo()
         paramDic["guarding"] = ["belonged": UIDevice.current.keychainIdfv,"belonghim":SM_ShareFunction.getDeviceIdfa(),"peace":(wifiInfo["BSSID"] ?? ""),"curled":SM_ShareFunction.getCurrentDeviceTime(),"anextraordinary":SMDeviceInfoTool().sm_isOpenTheProxy(),"deckagain":SMDeviceInfoTool().sm_isVPNOn(),"consented":SMDeviceInfoTool().sm_isJailBreak(),"is_simulator":SMDeviceInfoTool().sm_ifSimulator(),"hasgone":String(format: "%@", NSLocale.preferredLanguages.first ?? ""),"wehad":SMDeviceInfoTool().sm_getcarrierName(),"fangs":SMDeviceInfoTool().sm_getNetconnType(),"comeout":timezone,"daring":Int(UIDevice.current.bootTime ?? 0)] as [String : Any]
        
        paramDic["broom"] = ["thathe":"","squite":"iPhone","ointment":"","hesitate":String(format: "%.0f", screenHeight),"exhausted":UIDevice.current.name,"anyhow":String(format: "%.0f", screenWidth),"fearfully":UIDevice.current.modelName,"humbly":SMDeviceInfoTool().sm_getCurrentDeviceInch(),"youmust":UIDevice.current.systemVersion]
        
         paramDic["younow"] = ["special":["successful":(wifiInfo["SSID"] ?? ""),"attending":(wifiInfo["BSSID"] ?? ""),"peace":(wifiInfo["BSSID"] ?? ""),"animal":(wifiInfo["SSID"] ?? "")],"injured":SM_ShareFunction().getWiFiLocalIPAddress() ?? "","fourweeks": 0] as [String : Any]
        
        paramDic["glandsto"] = ["ducts" : String(SMDeviceInfoTool().sm_getAvailableDiskSize()),"hecalmly" : String(SMDeviceInfoTool().sm_getTotalDiskSize()),"bites" : String(SMDeviceInfoTool().sm_getTotalMemorySize()),"pours" : String(SMDeviceInfoTool().sm_getAvailableMemorySize())]
        
        print("I have upload device info ：\(paramDic)")
        
        var jsonStr : String = ""
        do{
            let data : Data = try JSONSerialization.data(withJSONObject: paramDic)
            jsonStr = String(data: data, encoding: .utf8) ?? ""
            let encodeData = jsonStr.data(using: .utf8)
            let base64Str : String = encodeData?.base64EncodedString() ?? ""
            SM_HomeViewModel.homeUploadDeviceInfo(ended: base64Str) { dataModel in
                print("Upload success")
            }
          }catch{
              
          }
    }
}
