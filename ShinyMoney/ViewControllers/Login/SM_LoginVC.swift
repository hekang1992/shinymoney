//
//  SM_LoginVC.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/7.
//

import UIKit
import Masonry
import TTTAttributedLabel
import NNModule_swift
class SM_LoginVC: UIViewController,TTTAttributedLabelDelegate{
    var scrollview : UIScrollView!
    var scrollContainerView : UIView!
    var phoneTextField : UITextField!
    var nextBtn : UIButton!
    var PrivacyPolicyLabel : TTTAttributedLabel!
    var guestModeBtn : UIButton!
    var helpCenterLabel : UILabel!
    var appVersionLabel : UILabel!
    var telPreDetailView : UIView!
    var ifShowTelPreDetailView : Bool! = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = mainColor
        self.buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let firstTime = SM_ShareFunction.getCurrentDeviceTime()
        UserDefaults.standard.set(firstTime, forKey: "comeToLoingVCTime")
    }

    func buildUI(){
        let starIcon = UIImageView(image: UIImage(named: "starIcon"))
        self.view.addSubview(starIcon)
        starIcon.mas_makeConstraints { make in
            make?.right.offset()(0)
            make?.top.offset()(147)
            make?.width.equalTo()(103)
            make?.height.equalTo()(114)
        }
        
        self.scrollview = UIScrollView()
        self.scrollview.backgroundColor = UIColor.clear
        self.scrollview.showsVerticalScrollIndicator = false
        self.scrollview.showsHorizontalScrollIndicator = false
        self.scrollview.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(self.scrollview)
        self.scrollview.mas_makeConstraints { make in
            make?.top.offset()(0)
            make?.left.offset()(0)
            make?.width.equalTo()(screenWidth)
            make?.bottom.offset()(0)
        }
        
        self.scrollContainerView = UIView()
        self.scrollContainerView.backgroundColor = UIColor.clear
        self.scrollview.addSubview(self.scrollContainerView)
        self.scrollContainerView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.width.equalTo()(screenWidth)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        let topAppNameLabel = UILabel()
        topAppNameLabel.text = "Shiny Money"
        topAppNameLabel.textColor = UIColor.white
        topAppNameLabel.font = UIFont.boldSystemFont(ofSize: 32)
        self.scrollContainerView.addSubview(topAppNameLabel)
        topAppNameLabel.mas_makeConstraints { make in
            make?.top.offset()(SM_ShareFunction.getStatusBarHeight() + 80)
            make?.centerX.equalTo()(self.scrollContainerView)?.offset()(33)
        }
        
        let topAppIcon = UIImageView()
        topAppIcon.image = UIImage(named: "appIcon")
        self.scrollContainerView.addSubview(topAppIcon)
        topAppIcon.mas_makeConstraints { make in
            make?.right.equalTo()(topAppNameLabel.mas_left)?.offset()(-7)
            make?.centerY.equalTo()(topAppNameLabel)
            make?.height.equalTo()(60)
            make?.width.equalTo()(60)
        }
        
        let phoneNumberFillTipLabel = UILabel()
        phoneNumberFillTipLabel.text = "Put your mobile number to get started"
        phoneNumberFillTipLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        phoneNumberFillTipLabel.textColor = UIColor.white
        self.scrollContainerView.addSubview(phoneNumberFillTipLabel)
        phoneNumberFillTipLabel.mas_makeConstraints { make in
            make?.top.equalTo()(topAppIcon.mas_bottom)?.offset()(85)
            make?.centerX.equalTo()(self.scrollContainerView)
        }
        
        let telPreView = UIView()
        telPreView.backgroundColor = UIColor(hex: "ffffff").withAlphaComponent(0.2)
        telPreView.layer.cornerRadius = 12
        self.scrollContainerView.addSubview(telPreView)
        telPreView.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.top.equalTo()(phoneNumberFillTipLabel.mas_bottom)?.offset()(70)
            make?.width.equalTo()(78)
            make?.height.equalTo()(48)
        }
        telPreView.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showOrDismissTelPreDetailViewAction))
        telPreView.addGestureRecognizer(tap)
        
        let preTelLabel = UILabel()
        preTelLabel.textColor = UIColor.white
        preTelLabel.font = UIFont.systemFont(ofSize: 18)
        preTelLabel.text = "+63"
        telPreView.addSubview(preTelLabel)
        preTelLabel.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.centerY.equalTo()(telPreView)
        }
        
        let downArrowIcon = UIImageView(image: UIImage(named: "downArrowIcon"))
        telPreView.addSubview(downArrowIcon)
        downArrowIcon.mas_makeConstraints { make in
            make?.left.equalTo()(preTelLabel.mas_right)?.offset()(10)
            make?.centerY.equalTo()(telPreView)
        }
        
        self.phoneTextField = UITextField()
        self.phoneTextField.keyboardType = .phonePad
        self.phoneTextField.textColor = UIColor.white
        self.phoneTextField.font = UIFont.systemFont(ofSize: 18)
        self.phoneTextField.placeholder = "Please fill in your phone number"
        self.phoneTextField.placeHolderColor = UIColor(hex: "ffffff").withAlphaComponent(0.2)
        self.scrollContainerView.addSubview(self.phoneTextField)
        self.phoneTextField.mas_makeConstraints { make in
            make?.left.equalTo()(telPreView.mas_right)?.offset()(19)
            make?.centerY.equalTo()(telPreView)
            make?.right.offset()(-32)
            make?.height.equalTo()(44)
        }
        
        let phoneBottomLine = UIView()
        phoneBottomLine.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.scrollContainerView.addSubview(phoneBottomLine)
        phoneBottomLine.mas_makeConstraints { make in
            make?.left.equalTo()(self.phoneTextField)
            make?.top.equalTo()(telPreView.mas_bottom)?.offset()(4)
            make?.right.offset()(-32)
            make?.height.equalTo()(1)
        }
        
        self.telPreDetailView = UIView()
        self.telPreDetailView.isHidden = true
        self.telPreDetailView.backgroundColor = UIColor.white
        self.telPreDetailView.layer.cornerRadius = 12
        self.scrollContainerView.addSubview(self.telPreDetailView)
        self.telPreDetailView.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.right.offset()(-32)
            make?.top.equalTo()(phoneBottomLine.mas_bottom)?.offset()(7)
            make?.height.equalTo()(48)
        }
        
        let nationFlagIcon = UIImageView()
        nationFlagIcon.image = UIImage(named: "nationalFlag")
        self.telPreDetailView.addSubview(nationFlagIcon)
        nationFlagIcon.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.centerY.equalTo()(self.telPreDetailView)
            make?.width.equalTo()(20)
            make?.height.equalTo()(16)
        }
        
        let countryLabel = UILabel()
        countryLabel.text = "Philippines（+63）"
        countryLabel.textColor = UIColor.black
        countryLabel.font = UIFont.systemFont(ofSize: 18)
        self.telPreDetailView.addSubview(countryLabel)
        countryLabel.mas_makeConstraints { make in
            make?.left.equalTo()(nationFlagIcon.mas_right)?.offset()(12)
            make?.centerY.equalTo()(nationFlagIcon)
        }
        
        let tickIcon = UIImageView()
        tickIcon.image = UIImage(named: "tickIcon")
        self.telPreDetailView.addSubview(tickIcon)
        tickIcon.mas_makeConstraints { make in
            make?.right.offset()(-24)
            make?.height.equalTo()(24)
            make?.width.equalTo()(24)
            make?.centerY.equalTo()(countryLabel)
        }
        
        self.nextBtn = SMImageTextButton()
        self.nextBtn.setTitle("Next", for: .normal)
        self.nextBtn.setImage(UIImage(named: "rightArrowIcon"), for: .normal)
        self.nextBtn.setTitleColor(UIColor(hex: "856CEB"), for: .normal)
        self.nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextBtn.backgroundColor = UIColor.white
        self.nextBtn.layer.cornerRadius = 12
        self.scrollContainerView.addSubview(self.nextBtn)
        self.nextBtn.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.right.offset()(-32)
            make?.height.equalTo()(58)
            make?.top.equalTo()(phoneBottomLine.mas_bottom)?.offset()(65)
        }
        self.nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        self.PrivacyPolicyLabel = TTTAttributedLabel(frame: .zero)
        self.PrivacyPolicyLabel.delegate = self
        self.PrivacyPolicyLabel.textAlignment = .left
        self.PrivacyPolicyLabel.enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
        self.PrivacyPolicyLabel.lineBreakMode = .byWordWrapping
        self.PrivacyPolicyLabel.numberOfLines = 0
        self.PrivacyPolicyLabel.font = UIFont.systemFont(ofSize: 13)
        self.PrivacyPolicyLabel.textColor = UIColor(hex: "ffffff").withAlphaComponent(0.5)
        
        let privacyPolicyStr = "Registering or logging into an account means that you agree to our Privacy Policy and Terms of Service."
        self.PrivacyPolicyLabel.setText(privacyPolicyStr){ mutableAttributedString in
            let range1 = (privacyPolicyStr as NSString).range(of: "Privacy Policy")
            mutableAttributedString!.addAttribute(.foregroundColor, value: UIColor(hex: "FCEA10"), range: range1)
            
            let range2 = (privacyPolicyStr as NSString).range(of: "Terms of Service")
            mutableAttributedString!.addAttribute(.foregroundColor, value: UIColor(hex: "FCEA10"), range: range2)
            return mutableAttributedString
        }
        
        var linkAttributes1: [NSAttributedString.Key: Any] = [:]
        linkAttributes1[.foregroundColor] = UIColor(hex: "FCEA10")
        self.PrivacyPolicyLabel.linkAttributes = linkAttributes1
               
        var activeAttributes1: [NSAttributedString.Key: Any] = [:]
        activeAttributes1[.foregroundColor] = UIColor(hex: "FCEA10")
        self.PrivacyPolicyLabel.activeLinkAttributes = activeAttributes1
               
        let firstRange = (privacyPolicyStr as NSString).range(of: "Privacy Policy")
        self.PrivacyPolicyLabel.addLink(to: URL(string: "https://omdublending.com/fingerStartled"), with: firstRange)
        
        let secondRange = (privacyPolicyStr as NSString).range(of: "Terms of Service")
        self.PrivacyPolicyLabel.addLink(to: URL(string: "https://omdublending.com/forgotSuddenly"), with: secondRange)
        
        self.scrollContainerView.addSubview(self.PrivacyPolicyLabel)
        self.PrivacyPolicyLabel.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.right.offset()(-32)
            make?.top.equalTo()(self.nextBtn.mas_bottom)?.offset()(20)
        }
        
        self.guestModeBtn = UIButton(type: .custom)
        self.guestModeBtn.setTitle("Guest mode", for: .normal)
        self.guestModeBtn.layer.cornerRadius = 20
        self.guestModeBtn.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.guestModeBtn.setTitleColor(UIColor.white, for: .normal)
        self.guestModeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.scrollContainerView.addSubview(self.guestModeBtn)
        self.guestModeBtn.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.scrollContainerView)
            make?.width.equalTo()(110)
            make?.height.equalTo()(40)
            make?.top.equalTo()(self.PrivacyPolicyLabel.mas_bottom)?.offset()(55)
        }
        self.guestModeBtn.addTarget(self, action: #selector(guestModeAction), for: .touchUpInside)
        
        self.helpCenterLabel = UILabel()
        self.helpCenterLabel.text = "Help Center"
        self.helpCenterLabel.textColor = UIColor(hex: "FCEA10")
        self.helpCenterLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.scrollContainerView.addSubview(self.helpCenterLabel)
        self.helpCenterLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.scrollContainerView)
            make?.top.equalTo()(self.guestModeBtn.mas_bottom)?.offset()(62)
        }
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.appVersionLabel = UILabel()
        self.appVersionLabel.text = "v" + (appVersion ?? "")
        self.appVersionLabel.textColor = UIColor(hex: "ffffff")
        self.appVersionLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.scrollContainerView.addSubview(self.appVersionLabel)
        self.appVersionLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.helpCenterLabel.mas_bottom)?.offset()(22)
            make?.centerX.equalTo()(self.scrollContainerView)
            make?.bottom.offset()(-20)
        }
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        print("link url -- %@",url.absoluteString)
        URLRouter.default.openRoute(url.absoluteString)
    }
    
    @objc func showOrDismissTelPreDetailViewAction(){
        self.ifShowTelPreDetailView = !self.ifShowTelPreDetailView
        if self.ifShowTelPreDetailView == false {
            self.telPreDetailView.isHidden = true
        }else{
            self.telPreDetailView.isHidden = false
        }
    }
    
    @objc func guestModeAction(){
        self.dismiss(animated: true)
    }
    
    @objc func nextAction(){
        if self.phoneTextField.text?.count == 0 {
            SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please enter your phone number first.")
            return
        }
        self.view.endEditing(true)
        SM_LoginViewModel.getLoginVertifyCode(telNum: self.phoneTextField.text!) { dataModel in
            if dataModel.onsinging == 0 {
                let enterCodeView : SM_LoginEnterCodeView = SM_LoginEnterCodeView(frame: self.view.bounds)
            enterCodeView.telStr = self.phoneTextField.text!
                self.view.addSubview(enterCodeView)
                enterCodeView.nextBlock = { codeStr in
                    SM_LoginViewModel.SMLogin(telNum: self.phoneTextField.text!, vertifyCode: codeStr) { dataModel in
                        if dataModel.onsinging == 0 {
                            self.dismiss(animated: true)
                            let user : SMUserModel =  SMUserModel(jsondata: dataModel.ended!)
                            SMUserModel.saveUser(user: user)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SMLOGINSUCCESS"), object: nil)
                            
                            self.dismiss(animated: true)
                                
                            let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                            let loginTime = SM_ShareFunction.getCurrentDeviceTime()
                            UserDefaults.standard.set(loginTime, forKey: "hasloginTime")
                            appdelegate.smAppdelegate.startLocationAction()
                        }
                    }
                }
             }
        }
    }
}
