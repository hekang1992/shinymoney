//
//  SM_ProcessStep04ViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/17.
//

import UIKit
import ContactsUI
import Contacts
class SM_ProcessStep04ViewController: UIViewController {
    var navView : SM_VertifyNavView!
    var titleStrLabel : UILabel!
    var scrollView : UIScrollView!
    var scrollContentView : UIView!
    var nextBtn : SMImageTextButton!
    var pageTopImageView : UIImageView!
    var local : String!
    var titleStr : String!
    var mainModel : SMStep04Model!
    var contactFillViewArr : [SM_ProcessContactFillView] = []
    var currentSelectPhoneFillView : SM_ProcessContactFillView?
    var nextStepManager : SMNextStepManager!
    var didloadTime : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.didloadTime = SM_ShareFunction.getCurrentDeviceTime()
        
        self.nextStepManager = SMNextStepManager()
        self.nextStepManager.local = self.local
        
        self.buildUI()
        self.getStep04Info()
    }

    func buildUI(){
        self.navView = SM_VertifyNavView()
        self.navView.configData(textColor: UIColor(hex: "ACF02C"), titleStr: self.titleStr, stepStr: "4.",backImageStr: "vertifyStep04Back")
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
        bgImageView.image = UIImage(named: "vertifyStep04Bg")
        self.view.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.navView.mas_bottom)?.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.pageTopImageView = UIImageView()
        self.pageTopImageView.image = UIImage(named: "vertifyStep04PageTop")
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
        self.nextBtn.backgroundColor = UIColor(hex: "ACF02C")
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
        
        if self.mainModel.expects != nil {
            for i in 0...self.mainModel.expects!.theyatArr.count - 1{
                let theyatModel : SMStep04TheyatModel = self.mainModel.expects!.theyatArr[i]
                let fillView : SM_ProcessContactFillView = SM_ProcessContactFillView(frame: CGRectZero)
                fillView.contactNumLabel.text = theyatModel.natives ?? ""
                if theyatModel.specimen?.count ?? 0 > 0 {
                    fillView.relationShipFillView.fillTextField.text = theyatModel.relation_name
                    fillView.phoneNumberFillView.fillTextField.text = (theyatModel.successful ?? "") + "-" + theyatModel.specimen!
                    fillView.currentSelectTitleStr = theyatModel.relation_name ?? ""
                    fillView.currentSelectIndex = theyatModel.looksup ?? ""
                    fillView.nameStr = theyatModel.successful
                    fillView.phoneStr = theyatModel.specimen
                }
                self.scrollContentView.addSubview(fillView)
                fillView.mas_makeConstraints { make in
                    make?.top.offset()(CGFloat(280*i))
                    make?.left.offset()(0)
                    make?.right.offset()(0)
                    make?.height.equalTo()(280)
                    if i == self.mainModel.expects!.theyatArr.count - 1 {
                        make?.bottom.offset()(-20)
                    }
                }
                self.contactFillViewArr.append(fillView)
                
                fillView.relationShipFillView.fillView.isUserInteractionEnabled = true
                fillView.relationShipFillView.fillTextField.isUserInteractionEnabled = false
                let chooseRelationShipTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseRelationShipAction))
                fillView.relationShipFillView.fillView.addGestureRecognizer(chooseRelationShipTap)
                
                fillView.phoneNumberFillView.fillView.isUserInteractionEnabled = true
                fillView.phoneNumberFillView.fillTextField.isUserInteractionEnabled = false
                let choosePhoneNumberTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoneNumberAction))
                fillView.phoneNumberFillView.fillView.addGestureRecognizer(choosePhoneNumberTap)
            }
        }
    }

    @objc func nextAction(){
        var dicsArr = [[String : String]]()
        for i in 0...self.mainModel.expects!.theyatArr.count - 1 {
            let fillView : SM_ProcessContactFillView = self.contactFillViewArr[i]
            let theyatModel : SMStep04TheyatModel = self.mainModel.expects!.theyatArr[i]
            let dic : [String : String] = ["specimen" : fillView.phoneStr ?? "","successful" : fillView.nameStr ?? "","looksup" : fillView.currentSelectIndex ?? "","weren" : theyatModel.weren ?? ""]
            dicsArr.append(dic)
        }
        
        do{
            let jsonData : Data = try JSONSerialization.data(withJSONObject: dicsArr)
            let jsonStr = String(data: jsonData, encoding: .utf8)
            let params : [String:String] = ["local":self.local ?? "","ended":jsonStr!]
            SM_HomeViewModel.saveStep04Info(params: params) { dataModel in
                if dataModel.onsinging == 0 {
                    let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.smAppdelegate.addAnalyticsPoint(productID: self.local ?? "", eventType: "7", pride: self.didloadTime ?? "", thesleeping: SM_ShareFunction.getCurrentDeviceTime())
                    
                    self.nextStepManager.getProductDetailInfo()
                }
            }
        }catch{
              
          }
    }
    
    @objc func getStep04Info(){
        SM_HomeViewModel.getStep04Info(local: self.local) { dataModel in
            if dataModel.onsinging == 0 {
                self.mainModel = SMStep04Model(jsondata: dataModel.ended!)
                self.setUpScrollView()
            }
        }
    }
    
    @objc func chooseRelationShipAction(ges : UIGestureRecognizer){
        let currentFillView = ges.view?.superview?.superview as! SM_ProcessContactFillView
        let theyatModel : SMStep04TheyatModel = self.mainModel.expects!.theyatArr[ges.view!.tag]
        var itemArr : [String] = []
        for fleshModel : SMStep04FleshModel in theyatModel.fleshArr {
            itemArr.append(fleshModel.successful ?? "")
        }
        let bottomSelectInfoView = SMBottomSelectInfoView.showBottomSelectView(style: .singleLevel, currentStep: 4, titleStr: "Relationship", itemArr: itemArr ,currentSelectStr:currentFillView.currentSelectTitleStr,cardArr: [])
        bottomSelectInfoView.selectItemBlock = {titleStr in
            currentFillView.currentSelectTitleStr = titleStr
            for eatsproperlyModel : SMStep04FleshModel in theyatModel.fleshArr {
                if eatsproperlyModel.successful == titleStr {
                    currentFillView.currentSelectIndex = eatsproperlyModel.bigboy
                }
            }
            currentFillView.relationShipFillView.fillTextField.text = titleStr
        }
    }
    
    @objc func choosePhoneNumberAction(ges : UIGestureRecognizer){
        self.currentSelectPhoneFillView = ges.view?.superview?.superview as? SM_ProcessContactFillView
        let contractPickerVC : CNContactPickerViewController = CNContactPickerViewController()
        contractPickerVC.delegate = self
        self.present(contractPickerVC, animated: true)
    }
}

extension SM_ProcessStep04ViewController : CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if contact.phoneNumbers.count == 0 {
            return
        }
        let phoneNumber : CNPhoneNumber? = contact.phoneNumbers[0].value
        if phoneNumber != nil {
            self.currentSelectPhoneFillView?.phoneNumberFillView.fillTextField.text = contact.familyName + contact.givenName + "-" + (phoneNumber?.stringValue ?? "")
        }
        self.currentSelectPhoneFillView?.nameStr = contact.familyName + contact.givenName
        self.currentSelectPhoneFillView?.phoneStr = phoneNumber?.stringValue ?? ""
    }
}
