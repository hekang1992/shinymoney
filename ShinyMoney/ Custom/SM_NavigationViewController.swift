//
//  SM_NavigationViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/7.
//

import UIKit
import Hue
class SM_NavigationViewController: UINavigationController,UIGestureRecognizerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        let navApperance = UINavigationBar.appearance()
        navApperance.barTintColor = UIColor.white
        navApperance.tintColor = UIColor.black
        navApperance.isTranslucent = false
        navApperance.shadowImage = UIImage()
        navApperance.setBackgroundImage((generateImageWithColor(color: UIColor.white)), for:.default)
        
        if #available(iOS 13.0, *) {
            let appearance : UINavigationBarAppearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.white
            appearance.shadowImage = UIImage()
            appearance.titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor : UIColor.black]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    func generateImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.viewControllers.count != 1 && gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count != 1 && gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "H5Back"), style: .done, target: self, action:#selector(backAction))
                self.interactivePopGestureRecognizer?.delegate = self
                self.interactivePopGestureRecognizer?.isEnabled = true
            }
        }else{
            viewController.hidesBottomBarWhenPushed = false;
        }
        
        if self.viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func backAction(){
        self.popViewController(animated: true)
    }
}
