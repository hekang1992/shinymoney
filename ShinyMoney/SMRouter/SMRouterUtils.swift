//
//  SMRouterUtils.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/28.
//

import Foundation
import NNModule_swift
class SMRouterUtils {
    private static let router = URLRouter.default
    init() {}
    
    static func setup() {
        let routeParser = URLRouteParser(defaultScheme: "word")
        URLRouter.default = URLRouter(routeParser: routeParser)
        
        self.registerRouterViewController()
        
        router.registerRoute(URLRouter.webLink) { routeUrl, navigator in
            guard let urlString = routeUrl.parameters["url"] as? String else {
                return false
            }
            
            let webVC : SMWebVC = SMWebVC(url: urlString)
            webVC.ifZDYNav = true
            UIViewController.getCurrentViewController()?.navigationController?.pushViewController(webVC, animated: true)
            return true
        }
    }
    
    private static func registerRouterViewController() {
        router.registerRoute("hawa.li") { routeUrl, navigator in
            switch routeUrl.path {
            case "/wholeDoesthat":
                print("传递的参数有:\(routeUrl.parameters)")
                let local = routeUrl.parameters["local"] as? String
                let vertifyProcessVC : SM_VertifyProcessViewController = SM_VertifyProcessViewController()
                vertifyProcessVC.local = local
                navigator.push(vertifyProcessVC, animated: true)
                return true
            case "/visitDisgust":
                let settingVC : SM_AccountManagementViewController = SM_AccountManagementViewController()
                navigator.push(settingVC, animated: true)
                return true
            case "/exceptBosss":
                let homeVC : SM_HomeVC = SM_HomeVC()
                navigator.push(homeVC, animated: true)
                return true
            case "/stillWhistled":
                let loginVC : SM_LoginVC = SM_LoginVC()
                navigator.push(loginVC, animated: true)
                return true
            case "/tryingGathered":
                let billVC : SM_BillVC = SM_BillVC()
                navigator.push(billVC, animated: true)
                return true
            case "/voiceEyesdarting":
              
                return true
            case "/beingenquiredMiddle":
                let loanAgainVC : SM_HomeLoanAgainViewController = SM_HomeLoanAgainViewController()
                navigator.push(loanAgainVC, animated: true)
                return true
            default: return false
            }
        }
    }
}
