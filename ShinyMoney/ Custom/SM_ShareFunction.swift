//
//  SM_ShareFunction.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/7.
//

import UIKit
import AdSupport
class SM_ShareFunction: NSObject {
  @objc static func hasNotch() -> Bool {
      if #available(iOS 11.0, *) {
        let topSafeAreaInset = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        return topSafeAreaInset > 20
      }
        return false
    }
    
    static func getStatusBarHeight() -> CGFloat {
        let statusBarFrame = UIApplication.shared.statusBarFrame
        return statusBarFrame.height
    }
    
    @objc static func getAPIParamWord() -> String{
        let alltowering = "ios"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let hadsailed = appVersion
        let thousand = UIDevice.current.modelName
        let eight = UIDevice.current.keychainIdfv
        let seven = UIDevice.current.systemVersion
        let explainedmore = "shimo"
        let theremight = SMUserModel.getSessionId() ?? ""
        let offin = UIDevice.current.keychainIdfv
        let change = getSomeWord()
        var totolWord = "alltowering=" + alltowering
        totolWord = totolWord + "&" + "hadsailed=" + hadsailed + "&" + "thousand=" + thousand
        totolWord = totolWord  + "&" + "eight=" + eight  + "&" + "seven=" + seven
        totolWord = totolWord + "&" + "explainedmore=" + explainedmore + "&" + "theremight=" + theremight
        totolWord = totolWord  + "&" + "offin=" + offin + "&" + "change=" + change
        return totolWord
    }
    
    static func getSomeWord() -> String {
        let wordsArray = ["Importance","Education","widely","regarded","crucial ","factors","shaping","individuals","societies","significance","extends","beyond","classrooms","influencing ","personal","development","economic"," prosperity","social","progress","essay","explore ","multifaceted","importance","modern","foremost","fundamental","knowledge","competencies ","navigate","complexities","literacy","numeracy","advanced","critical","thinking ","empowers ","aspirations","leadership","refused","essential","prioritize","economic","workforce","creating ","innovation","positioned","driver","Furthermore","lifelong","curiosity"]
        let random : Int = Int(arc4random_uniform(UInt32(wordsArray.count)))
        let word = wordsArray[random]
        return word
    }
    
    static func getDeviceIdfa() -> String {
        let adId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        return adId
    }
    
    @objc static func getCurrentDeviceTime() -> String{
         let date : Date = Date()
         let time = date.timeIntervalSince1970
         let timeString = String(format: "%.0f", time*1000)
         return timeString
     }
    
    @objc func getWiFiLocalIPAddress() -> String? {
           var address: String?
           var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
           guard getifaddrs(&ifaddr) == 0 else {
               return nil
           }
           guard let firstAddr = ifaddr else {
               return nil
           }
           for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
               let interface = ifptr.pointee
               let addrFamily = interface.ifa_addr.pointee.sa_family
               if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                   let name = String(cString: interface.ifa_name)
                   if name == "en0" {
                       var addr = interface.ifa_addr.pointee
                       var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                       getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                       address = String(cString: hostName)
                   }
               }
           }

           freeifaddrs(ifaddr)
           return address
       }
}
