//
//  SM_AccountManagementViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/11.
//

import UIKit

class SM_AccountManagementViewController: UIViewController {
    var navView : SM_VertifyNavView!
    var logoutBtn : UIButton!
    var signoutBtn : UIButton!
    var deleteBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.buildUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func buildUI(){
        self.navView = SM_VertifyNavView()
        self.navView.configData(textColor: UIColor(hex: "856CEB"), titleStr: "Account Management", stepStr: "",backImageStr: "vertifyStep05Back")
        self.view.addSubview(self.navView)
        self.navView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            if SM_ShareFunction.hasNotch() == true {
                make?.height.equalTo()(100)
            }else{
                make?.height.equalTo()(80)
            }
            make?.top.offset()(0)
        }
        self.navView.backBlock = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "vertifyStep05Bg")
        self.view.addSubview(backgroundImageView)
        backgroundImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.navView.mas_bottom)?.offset()(0)
            make?.bottom.offset()(0)
        }
        
        let starBackgroundImageView = UIImageView()
        starBackgroundImageView.image = UIImage(named: "accountManagerBg")
        self.view.addSubview(starBackgroundImageView)
        starBackgroundImageView.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.top.equalTo()(self.navView.mas_bottom)?.offset()(16)
            make?.bottom.offset()(-16)
        }
        
        let topIcon = UIImageView()
        topIcon.image = UIImage(named: "accountManagerTopIcon")
        self.view.addSubview(topIcon)
        topIcon.mas_makeConstraints { make in
            make?.top.equalTo()(backgroundImageView.mas_top)?.offset()(85)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(98)
            make?.width.equalTo()(98)
        }
        
        let managerAccountLabel : UILabel = UILabel()
        managerAccountLabel.text = "Account Management"
        managerAccountLabel.font = UIFont(name: "SFProDisplay-Black", size: 24)
        managerAccountLabel.textColor = UIColor.black
        self.view.addSubview(managerAccountLabel)
        managerAccountLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.view)
            make?.centerY.equalTo()(starBackgroundImageView)?.offset()(-60)
        }
        
        self.deleteBtn = UIButton(type: .custom)
        self.deleteBtn.setBackgroundImage(UIImage(named: "accountDeleteBg"), for: .normal)
        self.deleteBtn.backgroundColor = UIColor(hex:"856CEB")
        self.deleteBtn.layer.cornerRadius = 12
        self.view.addSubview(self.deleteBtn)
        self.deleteBtn.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.view)
            make?.width.equalTo()(300)
            make?.bottom.offset()(-86)
            make?.height.equalTo()(58)
        }
        self.deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        self.signoutBtn = UIButton(type: .custom)
        self.signoutBtn.setBackgroundImage(UIImage(named: "accountSignOutBg"), for: .normal)
        self.signoutBtn.backgroundColor = UIColor(hex:"856CEB")
        self.signoutBtn.layer.cornerRadius = 12
        self.view.addSubview(self.signoutBtn)
        self.signoutBtn.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.view)
            make?.width.equalTo()(300)
            make?.bottom.equalTo()(self.deleteBtn.mas_top)?.offset()(-16)
            make?.height.equalTo()(58)
        }
        self.signoutBtn.addTarget(self, action: #selector(signoutAction), for: .touchUpInside)
    }
    
    @objc func logoutAction(){
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.smAppdelegate.hasLocated = false
        appdelegate.smAppdelegate.hasGetLocation = false
        appdelegate.smAppdelegate.locationManager.stopUpdatingLocation()
        SM_AccountViewModel.logout { dataModel in
            if dataModel.onsinging == 0 {
                SMUserModel.cancelLogin()
                self.navigationController?.popViewController(animated: true)
                
                UserDefaults.standard.set("", forKey: "hasloginTime")
                NotificationCenter.default.post(name: NSNotification.Name("SMLOGOUT"), object: self)
                
            }
        }
    }
    
    @objc func deleteAction(){
        self.showChoiceAlert(messageStr: "Are you sure you want to delete account?", style: "2")
    }
    
    @objc func signoutAction(){
        self.showChoiceAlert(messageStr: "Are you sure you want to sign out?", style: "1")
    }
    
    func deleteAccount(){
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.smAppdelegate.hasLocated = false
        appdelegate.smAppdelegate.hasGetLocation = false
        appdelegate.smAppdelegate.locationManager.stopUpdatingLocation()
        SM_AccountViewModel.deleteAccount { dataModel in
            if dataModel.onsinging == 0 {
                SMUserModel.cancelLogin()
                self.navigationController?.popViewController(animated: true)
                
                UserDefaults.standard.set("", forKey: "hasloginTime")
                NotificationCenter.default.post(name: NSNotification.Name("SMLOGOUT"), object: self)
                
            }
        }
    }
    
    func signout(){
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.smAppdelegate.hasLocated = false
        appdelegate.smAppdelegate.hasGetLocation = false
        appdelegate.smAppdelegate.locationManager.stopUpdatingLocation()
        SM_AccountViewModel.logout { dataModel in
            if dataModel.onsinging == 0 {
                SMUserModel.cancelLogin()
                self.navigationController?.popViewController(animated: true)
                
                UserDefaults.standard.set("", forKey: "hasloginTime")
                NotificationCenter.default.post(name: NSNotification.Name("SMLOGOUT"), object: self)
                
            }
        }
    }
    
    func showChoiceAlert(messageStr : String,style : String) {
      let alertController = UIAlertController(title: "Tips", message: messageStr, preferredStyle: .alert)
      let option1 = UIAlertAction(title: "Confirm", style: .default) { action in
          if style == "1" {
              self.signout()
          }else{
              self.deleteAccount()
          }
      }
            
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
      }
            
      alertController.addAction(option1)
      alertController.addAction(cancelAction)
            
      self.present(alertController, animated: true, completion: nil)
    }
}
