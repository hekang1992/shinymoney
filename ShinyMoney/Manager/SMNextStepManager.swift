//
//  SMNextStepManager.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/29.
//

import UIKit
import NNModule_swift
class SMNextStepManager: NSObject {
    var local : String!
    var mainModel : SMProductDetailModel!
    var getOrderTime : String?
    func getProductDetailInfo(){
        SM_HomeViewModel.getProductDetail(local: self.local ?? "") { dataModel in
            if dataModel.onsinging == 0 {
                self.mainModel = SMProductDetailModel(jsondata: dataModel.ended!)
                if self.mainModel.supplying?.trusthim == "say2" {
                    let processStep02VC : SM_ProcessStep02ViewController = SM_ProcessStep02ViewController()
                    processStep02VC.local = self.local
                    processStep02VC.titleStr = self.mainModel.supplying?.loose
                    UIViewController.getCurrentViewController()?.navigationController?.pushViewController(processStep02VC, animated: true)
                }else if self.mainModel.supplying?.trusthim == "say3" {
                    let processStep03VC : SM_ProcessStep03ViewController = SM_ProcessStep03ViewController()
                    processStep03VC.local = self.local
                    processStep03VC.titleStr = self.mainModel.supplying?.loose
                    UIViewController.getCurrentViewController()?.navigationController?.pushViewController(processStep03VC, animated: true)
                }else if self.mainModel.supplying?.trusthim == "say4" {
                    let processStep04VC : SM_ProcessStep04ViewController = SM_ProcessStep04ViewController()
                    processStep04VC.local = self.local
                    processStep04VC.titleStr = self.mainModel.supplying?.loose
                    UIViewController.getCurrentViewController()?.navigationController?.pushViewController(processStep04VC, animated: true)
                }else if self.mainModel.supplying?.trusthim == "say5" {
                    self.toFinishBindCard()
                }else{
                    self.getOrderTime = SM_ShareFunction.getCurrentDeviceTime()
                    self.getOrderUrl(orderNo: self.mainModel.trackdown?.stirring ?? "",ifFromBank: true)
                }
            }
        }
    }
    
    func toFinishBindCard(){
        let bindBankCardTipView = SM_BindBankCardTipView.showBindBankCardTipView()
        bindBankCardTipView.gotItBlock = { [weak self] in
            self?.toSelectBankType()
        }
        bindBankCardTipView.closeBlock = {
            let vc = UIViewController.getCurrentViewController()?.navigationController!.viewControllers[1]
            UIViewController.getCurrentViewController()?.navigationController?.popToViewController(vc!, animated: true)
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
        
        selectBankTypeView.closeBlock = {
            let vc = UIViewController.getCurrentViewController()?.navigationController!.viewControllers[1]
            UIViewController.getCurrentViewController()?.navigationController?.popToViewController(vc!, animated: true)
        }
    }
    
    func getOrderUrl(orderNo : String,ifFromBank : Bool){
        SM_HomeViewModel.getOrderUrl(orderNo: orderNo) { dataModel in
            if dataModel.onsinging == 0 {
                let mainModel = SMOrderUrlModel(jsondata: dataModel.ended!)
                let webVC = SMWebVC(url: mainModel.deadly ?? "")
                webVC.ifFromBank = ifFromBank
                webVC.ifZDYNav = true
                UIViewController.getCurrentViewController()?.navigationController?.pushViewController(webVC, animated: true)
                
                let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.smAppdelegate.addAnalyticsPoint(productID: self.local ?? "", eventType: "9", pride: self.getOrderTime ?? "", thesleeping: SM_ShareFunction.getCurrentDeviceTime())
            }
        }
    }
}
