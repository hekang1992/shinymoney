//
//  SMVertifyIdentifyManager.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/29.
//

import UIKit
import AVFoundation
import AAILiveness
class SMVertifyIdentifyManager: NSObject {
    var superVC : SM_ProcessStep01ViewController!
    var local : String!
    var cardTypeStr : String! 
    var picFromSource : String!
    var advanceModel : SMRegAdvenceModel!
    var cardModel : SMCardInfoModel!
    var didloadTime : String?
    func takePhoto(ifTakeFacePhoto : Bool){
        self.picFromSource = "2"
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            return
        }
        let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (enable) in
                if enable == true {
                    DispatchQueue.main.async {
                        let picker : UIImagePickerController = UIImagePickerController()
                        picker.delegate = self
                        picker.sourceType = .camera
                        if ifTakeFacePhoto == true {
                            picker.cameraDevice = .front
                        }
                        picker.allowsEditing = true
                        picker.modalPresentationStyle = .fullScreen
                        self.superVC.present(picker, animated: true)
                       }
                }
            }
            return
        }
        if authStatus == .restricted || authStatus == .denied {
            let alertVC : UIAlertController = UIAlertController(title: nil, message: "To verify the authenticity of your identity document and prevent fraud, we require access to your camera. Please permit us to securely capture an electronic version of your identity document using the camera. We prioritize the protection of your personal information and will only use it for necessary identity verification purposes.", preferredStyle: .alert)
            let action0 : UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { action in
                
            }
            let action1 : UIAlertAction = UIAlertAction(title: "To set", style: .default) { action in
                let url = URL(string: UIApplication.openSettingsURLString)!
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }
            alertVC.addAction(action0)
            alertVC.addAction(action1)
            
            self.superVC.present(alertVC, animated: true)
            return
        }
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        if ifTakeFacePhoto == true {
            picker.cameraDevice = .front
        }
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        self.superVC.present(picker, animated: true)
    }
    
    func choosePhotoFromPhoneAlbum(){
        self.picFromSource = "1"
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            return
        }
        
        let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted || authStatus == .denied {
            let alertVC : UIAlertController = UIAlertController(title: nil, message: "To verify the authenticity of your identity document and prevent fraud, we require access to your camera. Please permit us to securely capture an electronic version of your identity document using the camera. We prioritize the protection of your personal information and will only use it for necessary identity verification purposes.", preferredStyle: .alert)
            let action0 : UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { action in
                
            }
            let action1 : UIAlertAction = UIAlertAction(title: "To set", style: .default) { action in
                let url = URL(string: UIApplication.openSettingsURLString)!
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }
            alertVC.addAction(action0)
            alertVC.addAction(action1)
            
            self.superVC.present(alertVC, animated: true)
            return
        }
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        self.superVC.present(picker, animated: true)
    }
    
    func faceRecognize(){
        AAILivenessSDK.initWith(.philippines)
        let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (enable) in
                if enable == true {
                    DispatchQueue.main.async {
                        self.getRegAdvanceCount()
                    }
                }
            }
            return
        }
        if authStatus == .restricted || authStatus == .denied{
            let alertVC : UIAlertController = UIAlertController(title: nil, message: "To verify the authenticity of your identity document and prevent fraud, we require access to your camera. Please permit us to securely capture an electronic version of your identity document using the camera. We prioritize the protection of your personal information and will only use it for necessary identity verification purposes.", preferredStyle: .alert)
            let action0 : UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { action in
                
            }
            let action1 : UIAlertAction = UIAlertAction(title: "To set", style: .default) { action in
                let url = URL(string: UIApplication.openSettingsURLString)!
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }
            alertVC.addAction(action0)
            alertVC.addAction(action1)
            
            self.superVC.present(alertVC, animated: true)
            return
        }

        self.getRegAdvanceCount()
    }
    
    func getRegAdvanceCount(){
        SM_HomeViewModel.getFaceRegAdvanceCount { dataModel in
            if dataModel.onsinging == 0 {
                self.advanceModel = SMRegAdvenceModel(jsondata: dataModel.ended!)
                let checkResult = AAILivenessSDK.configLicenseAndCheck(self.advanceModel.whofelt ?? "")
                if checkResult == "SUCCESS" {
                   self.toILivenessViewController()
                } else if checkResult == "LICENSE_EXPIRE" {
                    print("LICENSE_EXPIRE: please call your server's api to generate a new license")
                } else if checkResult == "APPLICATION_ID_NOT_MATCH" {
                    print("APPLICATION_ID_NOT_MATCH: please bind your app's bundle identifier on our cms website, then recall your server's api to generate a new license")
                } else {
                    print("\(checkResult)")
                }
            }
        }
    }
    
    func toILivenessViewController() {
        let vc = AAILivenessViewController()
        vc.detectionSuccessBlk = {(rawVC, result) in
            let livenessId = result.livenessId
            let bestImg = result.img
            let size = bestImg.size
            print("______livenessId: \(livenessId), imgSize: \(size.width), \(size.height)")
            rawVC.navigationController?.popViewController(animated: true)
            self.uploadFaceImage(faceImage: bestImg, livenessId: livenessId)
        }
        self.superVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    func uploadCardImage(cardImage : UIImage,picFromSource : String) {
        SMCustomActivityIndicatorView .showActivityInWindow(messageStr: "Uploading")
        SM_HomeViewModel.uploadImageToSever(image: cardImage, happen: picFromSource, local: self.local, bigboy: "11", protesting: "protesting", waddling: "", indisdain:"", isextremely: self.cardTypeStr) { dataModel in
            if dataModel.onsinging == 0 {
                SMCustomActivityIndicatorView.dismissActivityView()
                self.cardModel = SMCardInfoModel(jsondata: dataModel.ended!)
                let bottomSelectCardInfoView : SMBottomSelectInfoView = SMBottomSelectInfoView.showBottomCardInfoView(style: .cardInfo, currentStep: 1, titleStr: "ID Infomation", cardTypeStr: self.cardTypeStr, cardInfoModel: self.cardModel)
                bottomSelectCardInfoView.confirmCardInfoBlock = { [weak self] nameStr, numberStr, birthDateStr in
                    self?.uploadCardInfo(nameStr: nameStr, numberStr: numberStr, birthDateStr: birthDateStr)
                }
                bottomSelectCardInfoView.selectDateBlock = {[weak bottomSelectCardInfoView] dateStr in
                    bottomSelectCardInfoView?.nameTextfield.resignFirstResponder()
                    bottomSelectCardInfoView?.numberTextfield.resignFirstResponder()
                    let bottomSelectDateView : SMBottomSelectInfoView = SMBottomSelectInfoView.showBottomSelectDateView(style: .selectDate, dateStr: dateStr, currentStep: 1,titleStr: "Date selection")
                    bottomSelectDateView.confirmDateBlock = {[weak bottomSelectCardInfoView] dateStr in
                        bottomSelectCardInfoView?.dateBirthTextfield.text = dateStr
                    }
                }
            }
        }
    }
    
    func uploadFaceImage(faceImage : UIImage, livenessId : String) {
        SMCustomActivityIndicatorView .showActivityInWindow(messageStr: "Uploading")
        SM_HomeViewModel.uploadImageToSever(image: faceImage, happen: "", local: self.local, bigboy: "10", protesting: "protesting", waddling: livenessId, indisdain:self.advanceModel.indisdain ?? "", isextremely: self.cardTypeStr) { dataModel in
            SMCustomActivityIndicatorView.dismissActivityView()
            self.superVC.getCardIdentifyInfo()
            
            let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.smAppdelegate.addAnalyticsPoint(productID: self.local ?? "", eventType: "4", pride: self.didloadTime ?? "", thesleeping: SM_ShareFunction.getCurrentDeviceTime())
        }
    }
    
    func uploadCardInfo(nameStr : String, numberStr : String, birthDateStr : String){
        let arr : [String] = birthDateStr.components(separatedBy: "/")
        let 
        newBirthDateStr = String(format: "%@/%@/%@", arr[2],arr[1],arr[0])
        print("birthDateStr = %@",newBirthDateStr)
        SM_HomeViewModel.saveCardInfo(birth: newBirthDateStr, abedroom: numberStr, successful: nameStr, bigboy: "11", isextremely: self.cardTypeStr) { dataModel in
            if dataModel.onsinging == 0 {
                print("save info successfully")
                self.superVC.getCardIdentifyInfo()
                self.superVC.cardSelectTypeView.isUserInteractionEnabled = false
                self.faceRecognize()
                
                let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.smAppdelegate.addAnalyticsPoint(productID: self.local ?? "", eventType: "3", pride: self.didloadTime ?? "", thesleeping: SM_ShareFunction.getCurrentDeviceTime())
            }
        }
    }
}

extension SMVertifyIdentifyManager : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let image : UIImage! = info[.originalImage] as? UIImage
        self.uploadCardImage(cardImage: image, picFromSource: self.picFromSource)
    }
}
