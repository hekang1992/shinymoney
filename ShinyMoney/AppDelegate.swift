//
//  AppDelegate.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/3/28.
//

import UIKit
import IQKeyboardManagerSwift
import AppTrackingTransparency
import NNModule_swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var ifFirstEnter : Bool!
    @objc var smAppdelegate : SMAppdelegate! = SMAppdelegate()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        smAppdelegate.hasNetworkBlock = {
            self.registerNoti(appli: application)
        }
                
        SMRouterUtils.setup()
                
        IQKeyboardManager.shared.enable = true
        ifFirstEnter = true
 
        window?.rootViewController = SM_NavigationViewController(rootViewController:SM_LaunchViewController())
        return true
    }
    
    func printAllFontNames() {
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  Font: \(name)")
            }
        }
    }
    
    func goToLoginViewController(){
        let navigationVC : SM_NavigationViewController = SM_NavigationViewController(rootViewController: SM_LoginVC())
        self.window?.rootViewController = navigationVC
    }
    
    func goToHomeViewController(){
        let navigationVC : SM_NavigationViewController = SM_NavigationViewController(rootViewController: SM_ContainerVC())
        self.window?.rootViewController = navigationVC
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        self.initIdfa()
    }
    
    func initIdfa(){
        if #available(iOS 14, *) {
            let delayTime = DispatchTime.now() + .seconds(1)
            let delayedClosure: () -> Void = {
                ATTrackingManager.requestTrackingAuthorization { status in
                    if status == .notDetermined {
                        return
                    }
                    self.smAppdelegate.monitorNetwork(ifFirstEnter: self.ifFirstEnter)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: delayedClosure)
        } else {
            self.smAppdelegate.monitorNetwork(ifFirstEnter: self.ifFirstEnter)
        }
    }
    
    @objc func addH5Point(productId : String,startTime : String,endTime : String){
        self.smAppdelegate.addAnalyticsPoint(productID: productId, eventType: "10", pride: startTime, thesleeping: endTime)
    }
    
    @objc func openRouteUrl(url : String) {
        URLRouter.default.openRoute(url)
    }
    
    func registerNoti(appli:UIApplication){
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            if granted{
                print("requestAuthorization===yes")
            }else{
                print("requestAuthorization===no")
            }
        }
        appli.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let pushToken = deviceToken.map{String(format: "%02.2hhx", $0)}.joined()
        debugPrint("pushToken:\(pushToken)")
        SM_HomeViewModel.uploadNotificationToken(crazy: pushToken) { dataModel in
            print("upload notification token successfully")
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error=====\(error)")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let params = userInfo["params"] as! NSDictionary
        guard let url = params["shim"] as? String else{
            return
        }
        print("userInfo====\(params)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            URLRouter.default.openRoute(url )
        }
        completionHandler()
    }
}

