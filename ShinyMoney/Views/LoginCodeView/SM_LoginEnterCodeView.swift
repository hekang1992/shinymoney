//
//  SM_LoginEnterCodeView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/7.
//

import UIKit

class SM_LoginEnterCodeView: UIView {
    var enterCodeView : CodeInputView!
    var contentView : UIView!
    var resendCodeLabel : UILabel!
    var backBtn : UIButton!
    var nextBtn : UIButton!
    var nextBlock : ((_ codeStr : String)->())?
    var countDownSec = 60
    var telStr : String!
    var timer : Timer?
    var codeStr : String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.contentView = UIView()
        self.contentView.frame = CGRect(x: 0, y: screenHeight - 303, width: screenWidth, height: 303)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.roundCorners(corners: [.topLeft,.topRight], radius: 24)
        self.addSubview(self.contentView)
        
        self.enterCodeView = CodeInputView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64), inputType: 6, selectCodeBlock: { codeStr in
            self.codeStr = codeStr
        })
        self.contentView.addSubview(self.enterCodeView)
        
        let sendCodeTipLabel = UILabel()
        sendCodeTipLabel.numberOfLines = 0
        sendCodeTipLabel.text = "Please, enter 6-digit code we sent on your number as SMS"
        sendCodeTipLabel.font = UIFont.systemFont(ofSize: 16)
        sendCodeTipLabel.textColor = UIColor(hex: "000000").withAlphaComponent(0.5)
        self.contentView.addSubview(sendCodeTipLabel)
        sendCodeTipLabel.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.right.offset()(-32)
            make?.top.equalTo()(self.enterCodeView.mas_bottom)?.offset()(24)
        }
        
        self.resendCodeLabel = UILabel()
        self.resendCodeLabel.text = "Resend code in 60s"
        self.resendCodeLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        self.resendCodeLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(self.resendCodeLabel)
        self.resendCodeLabel.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.right.offset()(-32)
            make?.top.equalTo()(sendCodeTipLabel.mas_bottom)?.offset()(6)
        }
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
        self.resendCodeLabel.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resendCode))
        self.resendCodeLabel.addGestureRecognizer(tap)
        
        self.backBtn = UIButton(type: .custom)
        self.backBtn.setImage(UIImage(named: "sendCodeBackIcon"), for: .normal)
        self.backBtn.backgroundColor = UIColor(hex: "856CEB").withAlphaComponent(0.2)
        self.backBtn.layer.cornerRadius = 12
        self.contentView.addSubview(self.backBtn)
        self.backBtn.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.top.equalTo()(self.resendCodeLabel.mas_bottom)?.offset()(32)
            make?.width.equalTo()(58)
            make?.height.equalTo()(58)
        }
        self.backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.nextBtn = SMImageTextButton()
        self.nextBtn.setTitle("Next", for: .normal)
        self.nextBtn.setImage(UIImage(named: "rightWhiteArrowIcon"), for: .normal)
        self.nextBtn.setTitleColor(UIColor(hex: "ffffff"), for: .normal)
        self.nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextBtn.backgroundColor = UIColor(hex: "856CEB")
        self.nextBtn.layer.cornerRadius = 12
        self.contentView.addSubview(self.nextBtn)
        self.nextBtn.mas_makeConstraints { make in
            make?.left.equalTo()(self.backBtn.mas_right)?.offset()(20)
            make?.right.offset()(-32)
            make?.height.equalTo()(58)
            make?.centerY.equalTo()(self.backBtn)
        }
        self.nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    @objc func backAction(){
        self.removeFromSuperview()
    }
    
    @objc func nextAction(){
        self.removeFromSuperview()
        if self.codeStr == nil {
            SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please enter the verification code.")
            return
        }else if self.codeStr!.count < 6 {
            SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Please fill in the complete verification code.")
            return
        }
        self.nextBlock?(self.codeStr!)
    }
    
    @objc func countDownAction(){
            self.countDownSec -= 1
            if self.countDownSec == 0 {
                self.timer?.invalidate()
                self.resendCodeLabel.isUserInteractionEnabled = true
                self.countDownSec = 60
                self.resendCodeLabel.text = "Resend code"
                self.resendCodeLabel.textColor = UIColor(hex: "856CEB")
            }else{
                self.resendCodeLabel.isUserInteractionEnabled = false
                self.resendCodeLabel.text = String(format: "Resend code in %lds", self.countDownSec)
                self.resendCodeLabel.textColor = UIColor.black.withAlphaComponent(0.25)
            }
    }
    
    @objc func resendCode(){
        SM_LoginViewModel.getLoginVertifyCode(telNum: self.telStr!) { dataModel in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
        }
    }
}
