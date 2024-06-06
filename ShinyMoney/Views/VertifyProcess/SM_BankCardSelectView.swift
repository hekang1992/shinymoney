//
//  SM_BankCardSelectView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/26.
//

import UIKit

class SM_BankCardSelectView: UIView {
    var closeBtn : UIButton!
    var bankView : UIView!
    var walletView : UIView!
    var selectBankBlock : (() -> ())?
    var selectEwallet : (() -> ())?
    var closeBlock : (() -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    static func showSelectBankCardTypeView() -> SM_BankCardSelectView{
        let selectBankTypeView : SM_BankCardSelectView = SM_BankCardSelectView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(selectBankTypeView)
        
        return selectBankTypeView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let selectCardTypeBgImageview = UIImageView()
        selectCardTypeBgImageview.image = UIImage(named: "selectBankCardTypeBg")
        self.addSubview(selectCardTypeBgImageview)
        selectCardTypeBgImageview.mas_makeConstraints { make in
            make?.left.offset()(24)
            make?.right.offset()(-24)
            make?.centerY.equalTo()(self)?.offset()(-60)
            make?.height.equalTo()((screenWidth - 48)*271/327)
        }
        
        self.closeBtn = UIButton(type: .custom)
        self.closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.closeBtn.setImage(UIImage(named: "bindCardCloseIcon"), for: .normal)
        self.addSubview(self.closeBtn)
        self.closeBtn.mas_makeConstraints { make in
            make?.centerX.equalTo()(self)
            make?.width.equalTo()(32)
            make?.height.equalTo()(32)
            make?.top.equalTo()(selectCardTypeBgImageview.mas_bottom)?.offset()(40)
        }
        
        let titleStrLabel = UILabel()
        titleStrLabel.text = "Select card type"
        titleStrLabel.textColor = UIColor.black
        titleStrLabel.font = UIFont(name: "SFProDisplay-Black", size: 20)
        let attributes: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
               
        let attributedString = NSAttributedString(string: titleStrLabel.text!, attributes: attributes)
        titleStrLabel.attributedText = attributedString
        self.addSubview(titleStrLabel)
        titleStrLabel.mas_makeConstraints { make in
            make?.left.equalTo()(selectCardTypeBgImageview.mas_left)?.offset()(20)
            make?.top.equalTo()(selectCardTypeBgImageview.mas_top)?.offset()(88)
        }
        
        self.bankView = UIView()
        self.bankView.backgroundColor = UIColor.clear
        self.addSubview(self.bankView)
        self.bankView.mas_makeConstraints { make in
            make?.left.equalTo()(selectCardTypeBgImageview.mas_left)?.offset()(0)
            make?.top.equalTo()(titleStrLabel.mas_bottom)?.offset()(20)
            make?.height.equalTo()(50)
            make?.right.equalTo()(selectCardTypeBgImageview.mas_right)
        }
        self.bankView.isUserInteractionEnabled = true
        let bankTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectBank))
        self.bankView.addGestureRecognizer(bankTap)
        
        let bankTitleLabel = UILabel()
        bankTitleLabel.text = "Bank"
        bankTitleLabel.textColor = UIColor(hex: "856CEB")
        bankTitleLabel.font = UIFont(name: "SFProDisplay-Black", size: 16)
        let attributes01: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor(hex: "856CEB"),
                         .strokeWidth: -4.0
     ]
               
        let attributedString01 = NSAttributedString(string: bankTitleLabel.text!, attributes: attributes01)
        bankTitleLabel.attributedText = attributedString01
        self.addSubview(bankTitleLabel)
        bankTitleLabel.mas_makeConstraints { make in
            make?.left.equalTo()(selectCardTypeBgImageview.mas_left)?.offset()(20)
            make?.top.equalTo()(titleStrLabel.mas_bottom)?.offset()(40)
        }
        
        let bankEnterIcon = UIImageView()
        bankEnterIcon.image = UIImage(named: "selectBankCardTypeEnterIcon")
        self.addSubview(bankEnterIcon)
        bankEnterIcon.mas_makeConstraints { make in
            make?.right.equalTo()(selectCardTypeBgImageview.mas_right)?.offset()(-30)
            make?.centerY.equalTo()(bankTitleLabel)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
        
        let dashLine = UIImageView()
        dashLine.image = UIImage(named: "selectBankCardDashLineIcon")
        self.addSubview(dashLine)
        dashLine.mas_makeConstraints { make in
            make?.left.equalTo()(selectCardTypeBgImageview.mas_left)?.offset()(20)
            make?.right.equalTo()(selectCardTypeBgImageview.mas_right)?.offset()(-20)
            make?.height.equalTo()(1)
            make?.top.equalTo()(self.bankView.mas_bottom)?.offset()(14)
        }
        
        self.walletView = UIView()
        self.walletView.backgroundColor = UIColor.clear
        self.addSubview(self.walletView)
        self.walletView.mas_makeConstraints { make in
            make?.left.equalTo()(selectCardTypeBgImageview.mas_left)?.offset()(0)
            make?.top.equalTo()(dashLine.mas_bottom)?.offset()(0)
            make?.height.equalTo()(50)
            make?.right.equalTo()(selectCardTypeBgImageview.mas_right)
        }
        self.walletView.isUserInteractionEnabled = true
        let walletTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(selectEwalletAction))
        self.walletView.addGestureRecognizer(walletTap)
        
        let walletTitleLabel = UILabel()
        walletTitleLabel.text = "E-wallat"
        walletTitleLabel.textColor = UIColor(hex: "856CEB")
        walletTitleLabel.font = UIFont(name: "SFProDisplay-Black", size: 16)
        let attributes02: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor(hex: "856CEB"),
                         .strokeWidth: -4.0
     ]
               
        let attributedString02 = NSAttributedString(string: walletTitleLabel.text!, attributes: attributes02)
        walletTitleLabel.attributedText = attributedString02
        self.addSubview(walletTitleLabel)
        walletTitleLabel.mas_makeConstraints { make in
            make?.left.equalTo()(selectCardTypeBgImageview.mas_left)?.offset()(20)
            make?.top.equalTo()(dashLine.mas_bottom)?.offset()(20)
        }
        
        let walletEnterIcon = UIImageView()
        walletEnterIcon.image = UIImage(named: "selectBankCardTypeEnterIcon")
        self.addSubview(walletEnterIcon)
        walletEnterIcon.mas_makeConstraints { make in
            make?.right.equalTo()(selectCardTypeBgImageview.mas_right)?.offset()(-30)
            make?.centerY.equalTo()(walletTitleLabel)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
    }
    
    @objc func closeAction(){
        self.removeFromSuperview()
        self.closeBlock?()
    }
    
    @objc func selectBank(ges : UIGestureRecognizer){
        self.removeFromSuperview()
        self.selectBankBlock?()
    }
    
    @objc func selectEwalletAction(ges : UIGestureRecognizer){
        self.removeFromSuperview()
        self.selectEwallet?()
    }
}
