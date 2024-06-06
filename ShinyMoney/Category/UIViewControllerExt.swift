//
//  UIViewControllerExt.swift
//  LuckyPesoProject
//
//  Created by Apple on 2023/12/11.
//

import UIKit

extension UIViewController {
    @objc class func getCurrentViewController() -> UIViewController?{
        var currentWindow = UIApplication.shared.keyWindow ?? UIWindow()
        if currentWindow.windowLevel != UIWindow.Level.normal {
            let windowArr = UIApplication.shared.windows
            for window in windowArr {
                if window.windowLevel == UIWindow.Level.normal {
                    currentWindow = window
                    break
                }
            }
        }
        return UIViewController.getNextXController(nextController: currentWindow.rootViewController)
    }
    
    private class func  getNextXController(nextController: UIViewController?) -> UIViewController? {
        if nextController == nil {
            return nil
        }else if nextController?.presentedViewController != nil {
            return UIViewController.getNextXController(nextController: nextController?.presentedViewController)
        }else if let tabbar = nextController as? UITabBarController {
            return UIViewController.getNextXController(nextController: tabbar.selectedViewController)
        }else if let nav = nextController as? UINavigationController {
            return UIViewController.getNextXController(nextController: nav.visibleViewController)
        }
        return nextController
    }
}
