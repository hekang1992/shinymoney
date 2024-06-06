//
//  SM_ContainerVC.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/8.
//

import UIKit

class SM_ContainerVC: UIViewController {
    var homeVC : SM_HomeVC!
    var accountVC : SM_AccountVC!
    var billVC : SM_BillVC!
    var tabbar : SM_Tabbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: NSNotification.Name(rawValue: "SMLOGOUT"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: NSNotification.Name(rawValue: "SMLOGINSUCCESS"), object: nil)
    
        self.buildUI()
    }
    
    @objc func refreshUI(){
        self.tabbar.selectItemAction(button: self.tabbar.homeBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tabbar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabbar.isHidden = true
    }

    func buildUI(){
        self.homeVC = SM_HomeVC()
        self.addChild(self.homeVC)
        self.homeVC.view.frame = self.view.bounds
        self.view.addSubview(self.homeVC.view)
    
        self.billVC = SM_BillVC()
        self.addChild(self.billVC)
        self.billVC.view.frame = self.view.bounds
        self.view.addSubview(self.billVC.view)
        
        self.accountVC = SM_AccountVC()
        self.addChild(self.accountVC)
        self.accountVC.view.frame = self.view.bounds
        self.view.addSubview(self.accountVC.view)
        
        self.view.bringSubviewToFront(self.homeVC.view)
        
        self.tabbar = SM_Tabbar(frame: CGRectMake(0, screenHeight - 96, screenWidth, 96))
        if SM_ShareFunction.hasNotch() == false {
            self.tabbar = SM_Tabbar(frame: CGRectMake(0, screenHeight - 76, screenWidth, 76))
        }
        self.tabbar.roundCorners(corners: [.topLeft,.topRight], radius: 25)
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(self.tabbar)
        self.tabbar.tabbarSelectBlock = { currentSelectIndex in
            if currentSelectIndex == 0 {
                self.view.bringSubviewToFront(self.billVC.view)
                self.billVC.getOrderList()
            }else if currentSelectIndex == 1 {
                self.view.bringSubviewToFront(self.homeVC.view)
                self.homeVC.getHomeInfomationDataList()
            }else{
                self.view.bringSubviewToFront(self.accountVC.view)
                self.accountVC.addIndexPathsToAnimate()
                self.accountVC.performNextAnimation()
            }
        }
    }
    
}
