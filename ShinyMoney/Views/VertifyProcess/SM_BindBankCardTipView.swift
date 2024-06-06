//
//  SM_BindBankCardTipView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/25.
//

import UIKit

class SM_BindBankCardTipView: UIView {
    var bindBtn : UIButton!
    var titleLabel : UILabel!
    var contentLabel : UILabel!
    var closeBtn : UIButton!
    var gotItBlock : (() -> ())?
    var closeBlock : (() -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func showBindBankCardTipView() ->SM_BindBankCardTipView {
        let bindCardTipView : SM_BindBankCardTipView = SM_BindBankCardTipView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(bindCardTipView)
        
        return bindCardTipView
    }

    
    func buildUI(){
        self.backgroundColor = UIColor(hex:"000000").withAlphaComponent(0.3)
        
        let topbgImageView = UIImageView()
        topbgImageView.image = UIImage(named: "bindCardTopIcon")
        self.addSubview(topbgImageView)
        topbgImageView.mas_makeConstraints { make in
            make?.centerY.equalTo()(self)?.offset()(-60)
            make?.centerX.equalTo()(self)
            make?.width.equalTo()(screenWidth - 48)
            make?.height.equalTo()((screenWidth - 48)*246/327)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Binding Card"
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.font = UIFont(name: "SFProDisplay-Black", size: 20)
        let attributes01: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
               
        let attributedString01 = NSAttributedString(string: self.titleLabel.text!, attributes: attributes01)
        self.titleLabel.attributedText = attributedString01
        self.addSubview(self.titleLabel)
        self.titleLabel.mas_makeConstraints { make in
            make?.left.equalTo()(topbgImageView.mas_left)?.offset()(20)
            make?.top.equalTo()(topbgImageView.mas_top)?.offset()(88)
        }
        
        self.contentLabel = UILabel()
        self.contentLabel.numberOfLines = 0
        self.contentLabel.textAlignment = .center
        self.contentLabel.text = "You haven’t bound your bank card yet. You can only get a loan after binding your bank card."
        self.contentLabel.textColor = UIColor(hex: "856CEB")
        self.contentLabel.font = UIFont(name: "SFProDisplay-Black", size: 16)
        let attributes02: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor(hex: "856CEB"),
                         .strokeWidth: -4.0
     ]
               
        let attributedString02 = NSAttributedString(string: self.contentLabel.text ?? "", attributes: attributes02)
        self.contentLabel.attributedText = attributedString02
        self.addSubview(self.contentLabel)
        self.contentLabel.mas_makeConstraints { make in
            make?.left.equalTo()(topbgImageView.mas_left)?.offset()(12)
            make?.right.equalTo()(topbgImageView.mas_right)?.offset()(-12)
            make?.top.equalTo()(self.titleLabel.mas_bottom)?.offset()(24)
        }

        self.bindBtn = UIButton(type: .custom)
        self.bindBtn.backgroundColor = UIColor(hex: "856CEB")
        self.bindBtn.setTitleColor(UIColor.black, for: .normal)
        self.bindBtn.layer.cornerRadius = 32
        self.bindBtn.titleLabel?.font = UIFont(name: "SFProDisplay-Black", size: 20)
        self.bindBtn.setTitle("Go and bind cardit", for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
               
        let attributedString = NSAttributedString(string: self.bindBtn.titleLabel?.text ?? "", attributes: attributes)
        self.bindBtn.titleLabel?.attributedText = attributedString
        self.addSubview(self.bindBtn)
        self.bindBtn.mas_makeConstraints { make in
            make?.height.equalTo()(64)
            make?.width.equalTo()(240)
            make?.top.equalTo()(topbgImageView.mas_bottom)
            make?.centerX.equalTo()(self)
        }
        self.bindBtn.addTarget(self, action: #selector(bindAction), for: .touchUpInside)
        
        self.closeBtn = UIButton(type: .custom)
        self.closeBtn.addTarget(self, action: #selector(closeAction), for:.touchUpInside)
        self.closeBtn.setImage(UIImage(named: "bindCardCloseIcon"), for: .normal)
        self.addSubview(self.closeBtn)
        self.closeBtn.mas_makeConstraints { make in
            make?.height.equalTo()(32)
            make?.width.equalTo()(32)
            make?.top.equalTo()(self.bindBtn.mas_bottom)?.offset()(40)
            make?.centerX.equalTo()(self)
        }
    }
    
    @objc func bindAction(){
        self.removeFromSuperview()
        self.gotItBlock?()
    }
    
    @objc func closeAction() {
        self.removeFromSuperview()
        self.closeBlock?()
    }
    
}
