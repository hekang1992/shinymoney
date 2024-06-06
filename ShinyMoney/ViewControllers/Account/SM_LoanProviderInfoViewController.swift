//
//  SM_LoanProviderInfoViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/15.
//

import UIKit
import NNModule_swift
class SM_LoanProviderInfoViewController: UIViewController {
    var navView : SM_VertifyNavView!
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
        self.navView.configData(textColor: UIColor(hex: "856CEB"), titleStr: "Loan Provider Info", stepStr: "",backImageStr: "vertifyStep05Back")
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
        starBackgroundImageView.image = UIImage(named: "abountBg")
        self.view.addSubview(starBackgroundImageView)
        starBackgroundImageView.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.top.equalTo()(self.navView.mas_bottom)?.offset()(16)
            make?.bottom.offset()(-16)
        }
        
        let appIconImageView = UIImageView()
        appIconImageView.image = UIImage(named: "aboutAppIcon")
        self.view.addSubview(appIconImageView)
        appIconImageView.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.view)
            make?.width.equalTo()(108)
            make?.height.equalTo()(108)
            make?.top.equalTo()(starBackgroundImageView.mas_top)?.offset()(64)
        }
        
        let appNameLabel = UILabel()
        appNameLabel.text = "Shiny Money"
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        appNameLabel.textColor = UIColor.black
        self.view.addSubview(appNameLabel)
        appNameLabel.mas_makeConstraints { make in
            make?.top.equalTo()(appIconImageView.mas_bottom)?.offset()(30)
            make?.centerX.equalTo()(self.view)
        }
        
        let versionLabel = UILabel()
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionLabel.text = "current version：" + (appVersion ?? "")
        versionLabel.textColor = UIColor(hex: "666666")
        versionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.view.addSubview(versionLabel)
        versionLabel.mas_makeConstraints { make in
            make?.top.equalTo()(appNameLabel.mas_bottom)?.offset()(12)
            make?.centerX.equalTo()(self.view)
        }
        
        let lineIcon = UIImageView()
        lineIcon.image = UIImage(named: "aboutLine")
        self.view.addSubview(lineIcon)
        lineIcon.mas_makeConstraints { make in
            make?.left.offset()(56)
            make?.right.offset()(-56)
            make?.height.equalTo()(1)
            make?.top.equalTo()(versionLabel.mas_bottom)?.offset()(46)
        }
        
        let worldIcon = UIImageView()
        worldIcon.image = UIImage(named: "abountWorld")
        self.view.addSubview(worldIcon)
        worldIcon.mas_makeConstraints { make in
            make?.top.equalTo()(lineIcon.mas_bottom)?.offset()(52)
            make?.centerX.equalTo()(self.view)
            make?.width.equalTo()(32)
            make?.height.equalTo()(24)
        }
        
        let websiteLabel = UILabel()
        websiteLabel.text = "Product Website"
        websiteLabel.textColor = UIColor(hex: "#666666")
        websiteLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.view.addSubview(websiteLabel)
        websiteLabel.mas_makeConstraints { make in
            make?.top.equalTo()(worldIcon.mas_bottom)?.offset()(12)
            make?.centerX.equalTo()(self.view)
        }
        
        let websiteUrlLabel = UILabel()
        websiteUrlLabel.text = "https://omdublending.com/"
        websiteUrlLabel.textColor = UIColor(hex: "856CEB")
        websiteUrlLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.view.addSubview(websiteUrlLabel)
        websiteUrlLabel.mas_makeConstraints { make in
            make?.top.equalTo()(websiteLabel.mas_bottom)?.offset()(12)
            make?.centerX.equalTo()(self.view)
        }
        websiteUrlLabel.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(webAction))
        websiteUrlLabel.addGestureRecognizer(tap)
    }
    
    @objc func webAction(){
        URLRouter.default.openRoute("https://omdublending.com")        
    }
}
