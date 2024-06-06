//
//  SM_ProcessStep01ViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/17.
//

import UIKit

class SM_ProcessStep01ViewController: UIViewController {
    var navView : SM_VertifyNavView!
    var scrollView : UIScrollView!
    var scrollContentView : UIView!
    var uploadIDPhotoBgView : UIView!
    var faceRecognitionBgView : UIView!
    var cardSelectTypeView : UIView!
    var cardTypeLabel : UILabel!
    var cardModuleView : UIView!
    var cardUploadImageView : UIImageView!
    var cardPassImageView : UIImageView!
    var cardImageView : UIImageView!
    var faceRecognitionBgModuleView : UIView!
    var faceRecognitionSmileImageView : UIImageView!
    var faceRecognitionImageView : UIImageView!
    var faceRecognitionPassImageView : UIImageView!
    var nextBtn : SMImageTextButton!
    var vertifyIdentifyManager : SMVertifyIdentifyManager!
    var nextStepManager : SMNextStepManager!
    var local : String!
    var titleStr : String!
    var cardTypeStr : String!
    var cardPhotoHasOk : Bool = false
    var mainModel : SMIDTypeModel!
    var didloadTime : String?
    let environment = SMUserModel.getEnvironment()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.didloadTime = SM_ShareFunction.getCurrentDeviceTime()
        
        self.vertifyIdentifyManager = SMVertifyIdentifyManager()
        self.vertifyIdentifyManager.superVC = self
        self.vertifyIdentifyManager.local = self.local
        self.vertifyIdentifyManager.didloadTime = self.didloadTime
        
        self.nextStepManager = SMNextStepManager()
        self.nextStepManager.local = self.local
        
        self.buildUI()
        
        self.getCardIdentifyInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func buildUI(){
        self.navView = SM_VertifyNavView()
        self.navView.configData(textColor: UIColor(hex: "FC8574"), titleStr: self.titleStr, stepStr: "1.",backImageStr: "nav_back")
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
        bgImageView.image = UIImage(named: "vertify_bg")
        self.view.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.navView.mas_bottom)?.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = UIColor.clear
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(self.scrollView)
        self.scrollView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.width.equalTo()(screenWidth)
            make?.bottom.offset()(0)
            make?.top.equalTo()(bgImageView.mas_top)
        }
        
        self.scrollContentView = UIView()
        self.scrollContentView.backgroundColor = UIColor.clear
        self.scrollView.addSubview(self.scrollContentView)
        self.scrollContentView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.offset()(0)
            make?.width.equalTo()(screenWidth)
            make?.bottom.offset()(0)
        }
        
        self.uploadIDPhotoBgView = UIView()
        self.uploadIDPhotoBgView.backgroundColor = UIColor.black
        self.uploadIDPhotoBgView.layer.cornerRadius = 16
        self.uploadIDPhotoBgView.clipsToBounds = true
        self.scrollContentView.addSubview(self.uploadIDPhotoBgView)
        self.uploadIDPhotoBgView.mas_makeConstraints { make in
            make?.height.equalTo()(32)
            make?.width.equalTo()(160)
            make?.top.offset()(30)
            make?.centerX.equalTo()(self.scrollContentView)
        }
        
        let uploadIDPhotoBgLabel = UILabel()
        uploadIDPhotoBgLabel.text = "Upload ID photo"
        uploadIDPhotoBgLabel.textColor = UIColor.white
        uploadIDPhotoBgLabel.font = UIFont.systemFont(ofSize: 14)
        uploadIDPhotoBgView.addSubview(uploadIDPhotoBgLabel)
        uploadIDPhotoBgLabel.mas_makeConstraints { make in
            make?.center.equalTo()(uploadIDPhotoBgView)
        }
        
        let leftStarIcon = UIImageView()
        leftStarIcon.image = UIImage(named: "vertify_star")
        uploadIDPhotoBgView.addSubview(leftStarIcon)
        leftStarIcon.mas_makeConstraints { make in
            make?.centerY.equalTo()(uploadIDPhotoBgView)
            make?.right.equalTo()(uploadIDPhotoBgLabel.mas_left)?.offset()(-3)
        }
        
        let rightStarIcon = UIImageView()
        rightStarIcon.image = UIImage(named: "vertify_star")
        uploadIDPhotoBgView.addSubview(rightStarIcon)
        rightStarIcon.mas_makeConstraints { make in
            make?.centerY.equalTo()(uploadIDPhotoBgView)
            make?.left.equalTo()(uploadIDPhotoBgLabel.mas_right)?.offset()(3)
        }
        
        self.cardSelectTypeView = UIView()
        self.cardSelectTypeView.backgroundColor = UIColor(hex: "FFF6F1")
        self.cardSelectTypeView.layer.cornerRadius = 12
        self.scrollContentView.addSubview(self.cardSelectTypeView)
        self.cardSelectTypeView.mas_makeConstraints { make in
            make?.left.offset()(15)
            make?.right.offset()(-15)
            make?.top.equalTo()(uploadIDPhotoBgView.mas_bottom)?.offset()(16)
            make?.height.equalTo()(50)
        }
        self.cardSelectTypeView.isUserInteractionEnabled = true
        let selectCardTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCardAction))
        self.cardSelectTypeView.addGestureRecognizer(selectCardTap)
        
        self.cardTypeLabel = UILabel()
        self.cardTypeLabel.text = "ID Card"
        self.cardTypeLabel.textColor = UIColor(hex: "000000")
        self.cardTypeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.cardSelectTypeView.addSubview(self.cardTypeLabel)
        self.cardTypeLabel.mas_makeConstraints { make in
            make?.left.offset()(15)
            make?.centerY.equalTo()(self.cardSelectTypeView)
        }
        
        let cardTypeEnterArrow = UIImageView()
        cardTypeEnterArrow.image = UIImage(named: "vertity_arrow")
        self.cardSelectTypeView.addSubview(cardTypeEnterArrow)
        cardTypeEnterArrow.mas_makeConstraints { make in
            make?.right.offset()(-15)
            make?.centerY.equalTo()(self.cardSelectTypeView)
        }
        
        self.setUpCardModuleUI()
        
        self.faceRecognitionBgView = UIView()
        self.faceRecognitionBgView.backgroundColor = UIColor.black
        self.faceRecognitionBgView.layer.cornerRadius = 16
        self.faceRecognitionBgView.clipsToBounds = true
        self.scrollContentView.addSubview(self.faceRecognitionBgView)
        self.faceRecognitionBgView.mas_makeConstraints { make in
            make?.height.equalTo()(32)
            make?.width.equalTo()(160)
            make?.top.equalTo()(self.cardModuleView.mas_bottom)?.offset()(40)
            make?.centerX.equalTo()(self.scrollContentView)
        }
        
        let faceRecognitionLabel = UILabel()
        faceRecognitionLabel.text = "Face Recognition"
        faceRecognitionLabel.textColor = UIColor.white
        faceRecognitionLabel.font = UIFont.systemFont(ofSize: 14)
        self.faceRecognitionBgView.addSubview(faceRecognitionLabel)
        faceRecognitionLabel.mas_makeConstraints { make in
            make?.center.equalTo()(faceRecognitionBgView)
        }
        
        let leftStarIcon01 = UIImageView()
        leftStarIcon01.image = UIImage(named: "vertify_star")
        faceRecognitionBgView.addSubview(leftStarIcon01)
        leftStarIcon01.mas_makeConstraints { make in
            make?.centerY.equalTo()(faceRecognitionBgView)
            make?.right.equalTo()(faceRecognitionLabel.mas_left)?.offset()(-3)
        }
        
        let rightStarIcon01 = UIImageView()
        rightStarIcon01.image = UIImage(named: "vertify_star")
        faceRecognitionBgView.addSubview(rightStarIcon01)
        rightStarIcon01.mas_makeConstraints { make in
            make?.centerY.equalTo()(faceRecognitionBgView)
            make?.left.equalTo()(faceRecognitionLabel.mas_right)?.offset()(3)
        }
        
        self.setUpFaceRecognitionModuleUI()
        
        self.nextBtn = SMImageTextButton(type: .custom)
        self.nextBtn.layer.cornerRadius = 12
        self.nextBtn.backgroundColor = UIColor(hex: "ffffff")
        self.nextBtn.setTitle("Next", for: .normal)
        self.nextBtn.setImage(UIImage(named: "vertify_next"), for: .normal)
        self.nextBtn.setTitleColor(UIColor(hex: "856CEB"), for: .normal)
        self.nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.scrollContentView.addSubview(self.nextBtn)
        self.nextBtn.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.top.equalTo()(self.faceRecognitionBgModuleView.mas_bottom)?.offset()(28)
            make?.height.equalTo()(58)
            make?.bottom.offset()(-20)
        }
        self.nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    func setUpCardModuleUI(){
        self.cardModuleView = UIView()
        self.cardModuleView.backgroundColor = UIColor.clear
        self.scrollContentView.addSubview(self.cardModuleView)
        self.cardModuleView.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.top.equalTo()(self.cardSelectTypeView.mas_bottom)?.offset()(10)
            make?.height.equalTo()((screenWidth - 32)*260/343)
        }
        self.cardModuleView.isUserInteractionEnabled = true
        let showCardUploadExampleViewTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showCardUploadExampleView))
        self.cardModuleView.addGestureRecognizer(showCardUploadExampleViewTap)
        
        let cardBgImageView = UIImageView()
        cardBgImageView.image = UIImage(named: "vertify_cardExample")
        self.cardModuleView.addSubview(cardBgImageView)
        cardBgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.cardImageView = UIImageView()
        self.cardImageView.backgroundColor = UIColor(hex: "FFDAC2")
        self.cardImageView.layer.cornerRadius = 12
        self.cardImageView.clipsToBounds = true
        self.cardModuleView.addSubview(self.cardImageView)
        self.cardImageView.mas_makeConstraints { make in
            make?.left.offset()(25)
            make?.right.offset()(-25)
            make?.bottom.offset()(-25)
            make?.height.equalTo()((screenWidth - 82)*160/293)
        }
        
        self.cardUploadImageView = UIImageView()
        self.cardUploadImageView.image = UIImage(named: "vertify_upload")
        self.cardModuleView.addSubview(self.cardUploadImageView)
        self.cardUploadImageView.mas_makeConstraints { make in
            make?.center.equalTo()(self.cardImageView)
            make?.height.equalTo()(60)
            make?.width.equalTo()(60)
        }
        
        self.cardPassImageView = UIImageView()
        self.cardPassImageView.isHidden = true
        self.cardPassImageView.image = UIImage(named: "vertify_pass")
        self.cardModuleView.addSubview(self.cardPassImageView)
        self.cardPassImageView.mas_makeConstraints { make in
            make?.right.offset()(-28)
            make?.bottom.offset()(-26)
        }
    }
    
    func setUpFaceRecognitionModuleUI(){
        self.faceRecognitionBgModuleView = UIView()
        self.faceRecognitionBgModuleView.backgroundColor = UIColor.clear
        self.scrollContentView.addSubview(self.faceRecognitionBgModuleView)
        self.faceRecognitionBgModuleView.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.top.equalTo()(self.faceRecognitionBgView.mas_bottom)?.offset()(10)
            make?.height.equalTo()((screenWidth - 32)*260/343)
        }
        self.faceRecognitionBgModuleView.isUserInteractionEnabled = true
        let regTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(faceRegAction))
        self.faceRecognitionBgModuleView.addGestureRecognizer(regTap)
        
        let faceRecognitionBgImageView = UIImageView()
        faceRecognitionBgImageView.image = UIImage(named: "vertify_cardExample")
        self.faceRecognitionBgModuleView.addSubview(faceRecognitionBgImageView)
        faceRecognitionBgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.faceRecognitionImageView = UIImageView()
        self.faceRecognitionImageView.backgroundColor = UIColor(hex: "FFDAC2")
        self.faceRecognitionImageView.layer.cornerRadius = 12
        self.faceRecognitionImageView.clipsToBounds = true
        self.faceRecognitionBgModuleView.addSubview(self.faceRecognitionImageView)
        self.faceRecognitionImageView.mas_makeConstraints { make in
            make?.left.offset()(25)
            make?.right.offset()(-25)
            make?.bottom.offset()(-25)
            make?.height.equalTo()((screenWidth - 82)*160/293)
        }
        
        self.faceRecognitionSmileImageView = UIImageView()
        self.faceRecognitionSmileImageView.image = UIImage(named: "vertify_smileFace")
        self.faceRecognitionBgModuleView.addSubview(self.faceRecognitionSmileImageView)
        self.faceRecognitionSmileImageView.mas_makeConstraints { make in
            make?.center.equalTo()(self.faceRecognitionImageView)
            make?.height.equalTo()(142)
            make?.width.equalTo()(142)
        }
        
        self.faceRecognitionPassImageView = UIImageView()
        self.faceRecognitionPassImageView.isHidden = true
        self.faceRecognitionPassImageView.image = UIImage(named: "vertify_pass")
        self.faceRecognitionBgModuleView.addSubview(self.faceRecognitionPassImageView)
        self.faceRecognitionPassImageView.mas_makeConstraints { make in
            make?.right.offset()(-28)
            make?.bottom.offset()(-26)
        }
    }
    
    @objc func nextAction(){
        if self.environment == "ww" {
            if self.mainModel.films?.grasped == "1" && self.mainModel.comehome == "1"{
                self.nextStepManager.getProductDetailInfo()
            }else{
                SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please complete the information.")
            }
        }else{
            if self.mainModel.films?.grasped == "1" && self.mainModel.comehome == "1"{
                SM_HomeViewModel.mattressAbroad(local: self.local) { dataModel in
                    self.nextStepManager.getProductDetailInfo()
                }
            }else{
                SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please complete the information.")
            }
        }
        
    }
    
    @objc func showCardUploadExampleView(){
        if self.cardTypeStr == nil {
            SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please choose the type of ID card first.")
            return
        }
        let cardUploadExampleView : SM_CardUploadExampleView = SM_CardUploadExampleView()
        cardUploadExampleView.configData(cardNameStr: self.cardTypeStr)
        self.view.addSubview(cardUploadExampleView)
        cardUploadExampleView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        cardUploadExampleView.gotItBlock = { [weak self] in
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            }
            alertController.addAction(cancelAction)
            
            let takePhotoAction = UIAlertAction(title: "Take photo", style: .default) { _ in
                self?.vertifyIdentifyManager.takePhoto(ifTakeFacePhoto: false)
            }
            alertController.addAction(takePhotoAction)
            
            let chooseFromAblumAction = UIAlertAction(title: "Select from album", style: .default) { _ in
                self?.vertifyIdentifyManager.choosePhotoFromPhoneAlbum()
            }
            alertController.addAction(chooseFromAblumAction)
            
            self?.present(alertController, animated: true)
        }
    }
    
    @objc func faceRegAction(){
        if self.cardTypeStr == nil {
            SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please choose the type of ID card first.")
            return
        }
        if self.cardPhotoHasOk == false {
            self.showCardUploadExampleView()
            return
        }
        self.vertifyIdentifyManager.faceRecognize()
    }
    
    @objc func selectCardAction(){
        if(self.mainModel != nil){
            let selectCardAlertView : SMBottomSelectInfoView = SMBottomSelectInfoView.showBottomSelectView(style: .selectID, currentStep: 1, titleStr: "Select ID",itemArr: [],currentSelectStr: nil, cardArr: self.mainModel.contact ?? [])
            selectCardAlertView.delegate = self
        }
    }
    
    func getCardIdentifyInfo(){
        SM_HomeViewModel.getUserCardIdentifyData(local: self.local) { dataModel in
            if dataModel.onsinging == 0 {
                self.mainModel = SMIDTypeModel(jsondata: dataModel.ended!)
                if self.mainModel.films?.grasped == "1" {
                    self.setCardInfoModuleIsOK()
                }
                if self.mainModel.comehome == "1" {
                    self.setFaceRegModuleOK()
                }
            }
        }
    }
    
    func setCardInfoModuleIsOK(){
        self.cardPhotoHasOk = true
        self.cardImageView.kf.setImage(with: URL(string: self.mainModel.films?.deadly ?? ""))
        self.cardModuleView.isUserInteractionEnabled = false
        self.cardUploadImageView.isHidden = true
        self.cardPassImageView.isHidden = false
        self.cardTypeStr = self.mainModel.films?.isextremely
        self.vertifyIdentifyManager.cardTypeStr = self.cardTypeStr
        self.cardTypeLabel.text = self.cardTypeStr
        self.cardSelectTypeView.isUserInteractionEnabled = false
    }
    
    func setFaceRegModuleOK(){
        self.faceRecognitionImageView.kf.setImage(with: URL(string: self.mainModel.deadly ?? ""))
        self.faceRecognitionBgModuleView.isUserInteractionEnabled = false
        self.faceRecognitionSmileImageView.isHidden = true
        self.faceRecognitionPassImageView.isHidden = false
    }
}

extension SM_ProcessStep01ViewController : selectCardIDDelegate {
    func didSelectCardType(cardTypeName: String) {
        self.cardTypeLabel.text = cardTypeName
        self.cardTypeStr = cardTypeName
        self.vertifyIdentifyManager.cardTypeStr = cardTypeName
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.smAppdelegate.addAnalyticsPoint(productID: self.local ?? "", eventType: "2", pride: self.didloadTime ?? "", thesleeping: SM_ShareFunction.getCurrentDeviceTime())
    }
}
   
