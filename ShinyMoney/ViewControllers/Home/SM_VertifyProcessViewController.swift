//
//  SM_VertifyProcessViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/14.
//

import UIKit

class SM_VertifyProcessViewController: UIViewController {
    var scrollview : UIScrollView!
    var scrollContentView : UIView!
    var backBtn : UIButton!
    var wheelImageView : UIImageView!
    var startAndNextBtn : UIButton!
    var authenticationTipLabel : UILabel!
    var currentProcessIndex = 1
    var local : String!
    var mainModel : SMProductDetailModel!
    let environment = SMUserModel.getEnvironment()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getProductDetailInfo()
    }
    
    func setUpUI(){
        for subviews in self.view.subviews {
            subviews.removeFromSuperview()
        }
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "processBg")
        self.view.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.scrollview = UIScrollView()
        self.scrollview.showsVerticalScrollIndicator = true
        self.scrollview.showsHorizontalScrollIndicator = true
        self.scrollview.backgroundColor = UIColor.clear
        self.scrollview.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(self.scrollview)
        self.scrollview.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.width.equalTo()(screenWidth)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.scrollContentView = UIView()
        self.scrollContentView.backgroundColor = UIColor.clear
        self.scrollview.addSubview(self.scrollContentView)
        self.scrollContentView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.width.equalTo()(screenWidth)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.backBtn = UIButton(type: .custom)
        self.backBtn.setImage(UIImage(named: "Home_back"), for: .normal)
        self.backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.scrollContentView.addSubview(self.backBtn)
        self.backBtn.mas_makeConstraints { make in
            make?.left.offset()(24)
            make?.top.equalTo()(SM_ShareFunction.getStatusBarHeight() + 8)
            make?.width.equalTo()(44)
            make?.height.equalTo()(44)
        }
        
        let topIconImageView = UIImageView()
        topIconImageView.image = UIImage(named: "processTopIcon")
        self.scrollContentView.addSubview(topIconImageView)
        topIconImageView.mas_makeConstraints { make in
            make?.top.offset()(SM_ShareFunction.getStatusBarHeight() + 47)
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(screenWidth*208/375)
        }
        
        let curvedArrowIcon = UIImageView()
        curvedArrowIcon.image = UIImage(named: "processCurvedArrow")
        self.scrollContentView.addSubview(curvedArrowIcon)
        curvedArrowIcon.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(topIconImageView.mas_bottom)?.offset()(6)
            make?.height.equalTo()(screenWidth*14/75)
        }
        
        self.wheelImageView = UIImageView()
        self.scrollContentView.addSubview(self.wheelImageView)
        self.wheelImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(curvedArrowIcon.mas_top)?.offset()(20)
            make?.height.mas_equalTo()(screenWidth)
        }
        
        if environment == "ww" {
            self.wheelImageView.image = UIImage(named: "process01")
        }else{
            self.wheelImageView.image = UIImage(named: "review_process01")
        }
        
        
        let pointerArrowIcon = UIImageView()
        pointerArrowIcon.image = UIImage(named: "processDownArrow")
        self.scrollContentView.addSubview(pointerArrowIcon)
        pointerArrowIcon.mas_makeConstraints { make in
            make?.top.equalTo()(self.wheelImageView.mas_top)?.offset()(-4)
            make?.centerX.equalTo()(self.wheelImageView)
            make?.width.equalTo()(50)
            make?.height.equalTo()(57)
        }
        
        self.startAndNextBtn = UIButton(type: .custom)
        self.startAndNextBtn.setImage(UIImage(named: "processCenterStart"), for: .normal)
        self.startAndNextBtn.addTarget(self, action: #selector(startOrNextAction), for: .touchUpInside)
        self.scrollContentView.addSubview(self.startAndNextBtn)
        self.startAndNextBtn.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.wheelImageView)
            make?.centerY.equalTo()(self.wheelImageView)
            make?.width.equalTo()(100)
            make?.height.equalTo()(100)
        }
        
        self.authenticationTipLabel = UILabel()
        self.authenticationTipLabel.text = "Light up the big turntable in order to complete the authentication process"
        self.authenticationTipLabel.font = UIFont.systemFont(ofSize: 16)
        self.authenticationTipLabel.textColor = UIColor.white
        self.authenticationTipLabel.numberOfLines = 0
        self.authenticationTipLabel.textAlignment = .center
        self.scrollContentView.addSubview(self.authenticationTipLabel)
        self.authenticationTipLabel.mas_makeConstraints { make in
            make?.left.offset()(58)
            make?.right.offset()(-58)
            make?.top.equalTo()(self.wheelImageView.mas_bottom)?.offset()(10)
            make?.bottom.offset()(-20)
        }
        
    }
    
    @objc func startOrNextAction(){
        self.wheelAnimate()
    }
    
    func wheelAnimate(){
        if self.currentProcessIndex == 1 {
            let processStep01VC : SM_ProcessStep01ViewController = SM_ProcessStep01ViewController()
            processStep01VC.local = self.local
            processStep01VC.titleStr = self.mainModel.supplying?.loose
            self.navigationController?.pushViewController(processStep01VC, animated: true)
            return
        }else if currentProcessIndex == 5 {
            self.toFinishBindCard()
            return
        }else if currentProcessIndex == 6 {
            SMNextStepManager().getOrderUrl(orderNo: self.mainModel.trackdown?.stirring ?? "",ifFromBank: false)
        }else{
            UIView.animate(withDuration: 1.0) {
                if self.environment == "ww" {
                    self.wheelImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                }else{
                    self.wheelImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2/3)
                }
            } completion: { hadCompleted in
                if self.currentProcessIndex == 2 {
                    let processStep02VC : SM_ProcessStep02ViewController = SM_ProcessStep02ViewController()
                    processStep02VC.local = self.local
                    processStep02VC.titleStr = self.mainModel.supplying?.loose
                    self.navigationController?.pushViewController(processStep02VC, animated: true)
                }else if self.currentProcessIndex == 3 {
                    let processStep03VC : SM_ProcessStep03ViewController = SM_ProcessStep03ViewController()
                    processStep03VC.local = self.local
                    processStep03VC.titleStr = self.mainModel.supplying?.loose
                    self.navigationController?.pushViewController(processStep03VC, animated: true)
                }else if self.currentProcessIndex == 4 {
                    let processStep4VC : SM_ProcessStep04ViewController = SM_ProcessStep04ViewController()
                    processStep4VC.local = self.local
                    processStep4VC.titleStr = self.mainModel.supplying?.loose
                    self.navigationController?.pushViewController(processStep4VC, animated: true)
                }
            }
        }
    }
    
    func toFinishBindCard(){
        let bindBankCardTipView = SM_BindBankCardTipView.showBindBankCardTipView()
        bindBankCardTipView.gotItBlock = { [weak self] in
            self?.toSelectBankType()
        }
        return
    }
    
    func toSelectBankType(){
        let selectBankTypeView = SM_BankCardSelectView.showSelectBankCardTypeView()
        selectBankTypeView.selectBankBlock = { [weak self] in
            let processStep5VC : SM_ProcessStep05ViewController = SM_ProcessStep05ViewController()
            processStep5VC.local = self?.local
            processStep5VC.titleStr = self?.mainModel.supplying?.loose
            processStep5VC.currentBankType = "Bank"
            UIViewController.getCurrentViewController()?.navigationController?.pushViewController(processStep5VC, animated: true)
        }
        
        selectBankTypeView.selectEwallet = { [weak self] in
            let processStep5VC : SM_ProcessStep05ViewController = SM_ProcessStep05ViewController()
            processStep5VC.local = self?.local
            processStep5VC.titleStr = self?.mainModel.supplying?.loose
            processStep5VC.currentBankType = "E-wallet"
            UIViewController.getCurrentViewController()?.navigationController?.pushViewController(processStep5VC, animated: true)
        }
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getProductDetailInfo(){
        SM_HomeViewModel.getProductDetail(local: self.local ?? "") { dataModel in
            if dataModel.onsinging == 0 {
                self.setUpUI()

                self.mainModel = SMProductDetailModel(jsondata: dataModel.ended!)
                if self.mainModel.supplying?.trusthim == "say1" {
                    self.currentProcessIndex = 1
                    if self.environment == "ww" {
                        self.wheelImageView.image = UIImage(named: "process01")
                    }else{
                        self.wheelImageView.image = UIImage(named: "review_process01")
                    }
                    self.startAndNextBtn.setImage(UIImage(named: "processCenterStart"), for: .normal)
                }else if self.mainModel.supplying?.trusthim == "say2" {
                    self.currentProcessIndex = 2
                    if self.environment == "ww" {
                        self.wheelImageView.image = UIImage(named: "process02")
                    }else{
                        self.wheelImageView.image = UIImage(named: "review_process02")
                    }
                    self.startAndNextBtn.setImage(UIImage(named: "processCenterNext"), for: .normal)
                }else if self.mainModel.supplying?.trusthim == "say3" {
                    self.currentProcessIndex = 3
                    if self.environment == "ww" {
                        self.wheelImageView.image = UIImage(named: "process03")
                    }else{
                        self.wheelImageView.image = UIImage(named: "review_process03")
                    }
                    self.startAndNextBtn.setImage(UIImage(named: "processCenterNext"), for: .normal)
                }else if self.mainModel.supplying?.trusthim == "say4" {
                    self.currentProcessIndex = 4
                    self.wheelImageView.image = UIImage(named: "process04")
                    self.startAndNextBtn.setImage(UIImage(named: "processCenterNext"), for: .normal)
                }else if self.mainModel.supplying?.trusthim == "say5" {
                    self.currentProcessIndex = 5
                    if self.environment == "ww" {
                        self.wheelImageView.image = UIImage(named: "process05")
                    }else{
                        self.wheelImageView.image = UIImage(named: "review_process04")
                    }
                    self.startAndNextBtn.setImage(UIImage(named: "processCenterNext"), for: .normal)
                }else{
                    self.currentProcessIndex = 6
                    if self.environment == "ww" {
                        self.wheelImageView.image = UIImage(named: "process05")
                    }else{
                        self.wheelImageView.image = UIImage(named: "review_process04")
                    }
                    self.startAndNextBtn.setImage(UIImage(named: "processCenterNext"), for: .normal)
                }
            }
        }
    }
}
