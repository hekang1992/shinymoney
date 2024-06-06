//
//  SM_ProcessStep02ViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/17.
//

import UIKit

class SM_ProcessStep02ViewController: UIViewController {
    var navView : SM_VertifyNavView!
    var titleStrLabel : UILabel!
    var scrollView : UIScrollView!
    var scrollContentView : UIView!
    var nextBtn : SMImageTextButton!
    var pageTopImageView : UIImageView!
    var local : String!
    var titleStr : String!
    var mainModel : SMStep02Model!
    var fillViewArr : [SM_ProcessFillView] = []
    var nextStepManager : SMNextStepManager!
    var didloadTime : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.smAppdelegate.getAllCityLocationList()
        
        self.didloadTime = SM_ShareFunction.getCurrentDeviceTime()
        
        self.nextStepManager = SMNextStepManager()
        self.nextStepManager.local = self.local
        
        self.buildUI()
        self.getBasicInfoData()
    }

    func buildUI() {
        self.navView = SM_VertifyNavView()
        self.navView.configData(textColor: UIColor(hex: "7BD4FF"), titleStr: self.titleStr, stepStr: "2.",backImageStr: "vertifyStep02Back")
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
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "vertifyStep02Bg")
        self.view.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.navView.mas_bottom)?.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.pageTopImageView = UIImageView()
        self.pageTopImageView.image = UIImage(named: "vertifyStep02PageTop")
        self.view.addSubview(self.pageTopImageView)
        self.pageTopImageView.mas_makeConstraints { make in
            make?.left.offset()(22)
            make?.right.offset()(-22)
            make?.top.equalTo()(self.navView.mas_bottom)?.offset()(37)
            make?.height.equalTo()((screenWidth - 44)*126/331)
        }
        
        self.titleStrLabel = UILabel()
        self.titleStrLabel.numberOfLines = 0
        self.titleStrLabel.text = "Please fill in the following information carefully"
        self.titleStrLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 15)
        self.titleStrLabel.textColor = UIColor.black
        self.view.addSubview(self.titleStrLabel)
        self.titleStrLabel.mas_makeConstraints { make in
            make?.right.equalTo()(pageTopImageView.mas_right)?.offset()(-28)
            make?.left.equalTo()(pageTopImageView.mas_left)?.offset()(100)
            make?.bottom.equalTo()(pageTopImageView.mas_bottom)?.offset()(-42)
        }
        
        let fileBehindImageView = UIImageView()
        fileBehindImageView.image = UIImage(named: "vertifyStep02File01")
        self.view.addSubview(fileBehindImageView)
        fileBehindImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
            make?.height.equalTo()(screenWidth*169/375)
        }
        
        let pageContentView = UIView()
        pageContentView.backgroundColor = UIColor.white
        self.view.addSubview(pageContentView)
        pageContentView.mas_makeConstraints { make in
            make?.left.offset()(22)
            make?.right.offset()(-22)
            make?.top.equalTo()(pageTopImageView.mas_bottom)
            make?.bottom.offset()(0)
        }
        
        let fileBeforeImageView = UIImageView()
        fileBeforeImageView.image = UIImage(named: "vertifyStep02File02")
        self.view.addSubview(fileBeforeImageView)
        fileBeforeImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
            make?.height.equalTo()(screenWidth*110/375)
        }
        
        self.nextBtn = SMImageTextButton(type: .custom)
        self.nextBtn.backgroundColor = UIColor(hex: "7BD4FF")
        self.nextBtn.layer.cornerRadius = 12
        self.nextBtn.setTitle("Next", for: .normal)
        self.nextBtn.setTitleColor(UIColor.black, for: .normal)
        self.nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextBtn.setImage(UIImage(named: "vertifyNext"), for: .normal)
        self.view.addSubview(self.nextBtn)
        self.nextBtn.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.right.offset()(-38)
            make?.bottom.equalTo()(fileBeforeImageView.mas_top)?.offset()(-12)
            make?.height.equalTo()(58)
        }
        self.nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
                
    }
    
    func setUpScrollView(){
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = UIColor.clear
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(self.scrollView)
        self.scrollView.mas_makeConstraints { make in
            make?.left.offset()(22)
            make?.width.equalTo()(screenWidth - 44)
            make?.bottom.equalTo()(self.nextBtn.mas_top)?.offset()(-20)
            make?.top.equalTo()(self.pageTopImageView.mas_bottom)
        }
      
        self.scrollContentView = UIView()
        self.scrollContentView.backgroundColor = UIColor.clear
        self.scrollView.addSubview(self.scrollContentView)
        self.scrollContentView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.offset()(0)
            make?.width.equalTo()(screenWidth - 44)
            make?.bottom.offset()(0)
        }
        
        for i in 0...self.mainModel.callerArr.count - 1 {
            let fillView : SM_ProcessFillView = SM_ProcessFillView(frame: CGRectZero)
            let callerModel : SMStep02CallerModel = self.mainModel.callerArr[i]
            var fillIconNameStr : String = ""
            if callerModel.calledagain == "hello2" {
                fillIconNameStr = "vertifyEnterIcon"
            }else {
                fillIconNameStr = "vertifyPulldownIcon"
                fillView.fillView.isUserInteractionEnabled = true
                fillView.fillView.tag = i
                fillView.fillTextField.isUserInteractionEnabled = false
                let fillViewClickTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fillViewClickAction))
                fillView.fillView.addGestureRecognizer(fillViewClickTap)
            }
            fillView.configData(styleColor: UIColor(hex: "7AD2FC"), fillIconName: fillIconNameStr, titleStr: callerModel.loose ?? "")
            fillView.fillTextField.placeholder = callerModel.stroking ?? ""
            if callerModel.arejust?.count ?? 0 > 0 {
                fillView.fillTextField.text = callerModel.arejust!
                if callerModel.calledagain == "hello1" {
                    fillView.currentSelectTitleStr = callerModel.arejust!
                    fillView.currentSelectIndex = callerModel.bigboy!
                }
            }
            if callerModel.asclose == "1" {
                fillView.fillTextField.keyboardType = .numberPad
            }
            fillView.backgroundColor = UIColor.clear
            self.scrollContentView.addSubview(fillView)
            fillView.mas_makeConstraints { make in
                make?.top.offset()(CGFloat(36 + 96*i))
                make?.left.offset()(0)
                make?.right.offset()(0)
                make?.height.equalTo()(96)
                if i == self.mainModel.callerArr.count - 1 {
                    make?.bottom.offset()(-20)
                }
            }
            self.fillViewArr.append(fillView)
        }
    }
    
    func getBasicInfoData(){
        SM_HomeViewModel.getStep02Info(local: self.local) { dataModel in
            if dataModel.onsinging == 0 {
                self.mainModel = SMStep02Model(jsondata: dataModel.ended!)
                self.setUpScrollView()
            }
        }
    }
    
    @objc func nextAction(){
        var params : [String : String] = ["local" : self.local,"ending" : SM_ShareFunction.getSomeWord()]
        for i in 0...self.mainModel.callerArr.count - 1 {
            let callerModel : SMStep02CallerModel = self.mainModel.callerArr[i]
            let fillView : SM_ProcessFillView = self.fillViewArr[i]
            if callerModel.calledagain == "hello2" || callerModel.calledagain == "hello3"{
                params[callerModel.onsinging!] = fillView.fillTextField.text
            }else{
                params[callerModel.onsinging!] = fillView.currentSelectIndex
            }
        }
        
        SM_HomeViewModel.saveStep02Info(params: params) { dataModel in
            if dataModel.onsinging == 0 {
                let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.smAppdelegate.addAnalyticsPoint(productID: self.local ?? "", eventType: "5", pride: self.didloadTime ?? "", thesleeping: SM_ShareFunction.getCurrentDeviceTime())
                
                self.nextStepManager.getProductDetailInfo()
            }
        }
    }
    
    @objc func fillViewClickAction(ges : UIGestureRecognizer){
        self.view.endEditing(true)
        let currentFillView = ges.view?.superview as! SM_ProcessFillView
        let callerModel : SMStep02CallerModel = self.mainModel.callerArr[ges.view!.tag]
        if callerModel.calledagain == "hello1"{
            self.selectEnum(callerModel: callerModel, currentFillView: currentFillView)
        }else{
            self.selectCity(callerModel: callerModel, currentFillView: currentFillView)
        }
    }
    
    func selectEnum(callerModel : SMStep02CallerModel,currentFillView : SM_ProcessFillView){
        var itemArr : [String] = []
        for eatsproperlyModel : SMStep02EatsproperlyModel in callerModel.eatsproperlyArr {
            itemArr.append(eatsproperlyModel.successful ?? "")
        }
        let bottomSelectInfoView = SMBottomSelectInfoView.showBottomSelectView(style: .singleLevel, currentStep: 2, titleStr: callerModel.loose ?? "", itemArr: itemArr ,currentSelectStr:currentFillView.currentSelectTitleStr,  cardArr: [])
        bottomSelectInfoView.selectItemBlock = {titleStr in
            currentFillView.currentSelectTitleStr = titleStr
            for eatsproperlyModel : SMStep02EatsproperlyModel in callerModel.eatsproperlyArr {
                if eatsproperlyModel.successful == titleStr {
                    currentFillView.currentSelectIndex = eatsproperlyModel.bigboy
                }
            }
            currentFillView.fillTextField.text = titleStr
        }
    }
    
    func selectCity(callerModel : SMStep02CallerModel,currentFillView : SM_ProcessFillView){
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if appdelegate.smAppdelegate.cityLocationModel == nil {
            return
        }
        var mainlocationModel : SMCityLocationModel = appdelegate.smAppdelegate.cityLocationModel!

        var itemArr : [String] = []
        for locationModel : SMCityLocationModel in mainlocationModel.theyatArr {
            itemArr.append(locationModel.successful ?? "")
        }
        let bottomSelectInfoView = SMBottomSelectInfoView.showBottomSelectView(style: .multiLevel, currentStep: 2, titleStr: callerModel.loose ?? "", itemArr: itemArr ,currentSelectStr:currentFillView.currentSelectTitleStr,  cardArr: [])
        bottomSelectInfoView.selectItemBlock = { [weak bottomSelectInfoView] titleStr in
            for locationModel : SMCityLocationModel in mainlocationModel.theyatArr {
                if locationModel.successful == titleStr {
                    mainlocationModel = locationModel
                    if mainlocationModel.theyatArr.count > 0 {
                        var itemArr : [String] = []
                        for locationModel : SMCityLocationModel in mainlocationModel.theyatArr {
                            itemArr.append(locationModel.successful ?? "")
                        }
                        bottomSelectInfoView?.itemArr = itemArr
                        bottomSelectInfoView?.tableView.reloadData()
                    }else{
                        bottomSelectInfoView?.removeFromSuperview()
                        currentFillView.fillTextField.text = bottomSelectInfoView?.selectResultLabel.text
                    }
                }
            }
        }
    }
    
    deinit{
        print("deinit。。。。。")
    }
}
