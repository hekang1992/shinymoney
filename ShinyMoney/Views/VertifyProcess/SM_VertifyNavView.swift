//
//  SM_VertifyNavView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/17.
//

import UIKit

class SM_VertifyNavView: UIView {
    var titleStrLabel : UILabel!
    var backBtn : UIButton!
    var stepLabel : UILabel!
    var backBlock : (() -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.backgroundColor = UIColor.white
        
        self.titleStrLabel = UILabel()
        self.titleStrLabel.textColor = UIColor(hex: "FC8574")
        self.titleStrLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.addSubview(self.titleStrLabel)
        self.titleStrLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self)
            if SM_ShareFunction.hasNotch() == true {
                make?.top.offset()(54)
            }else{
                make?.top.offset()(30)
            }
        }
        
        self.stepLabel = UILabel()
        self.stepLabel.textColor = UIColor(hex: "FC8574")
        self.stepLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.addSubview(self.stepLabel)
        self.stepLabel.mas_makeConstraints { make in
            make?.centerY.equalTo()(self.titleStrLabel)
            make?.right.offset()(-16)
        }
        
        self.backBtn = UIButton(type: .custom)
        self.backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        self.backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.addSubview(self.backBtn)
        self.backBtn.mas_makeConstraints { make in
            make?.left.offset()(14)
            make?.centerY.equalTo()(self.titleStrLabel)
            make?.width.equalTo()(36)
            make?.height.equalTo()(22)
        }
        
    }
    
    func configData(textColor : UIColor,titleStr : String,stepStr : String, backImageStr : String) {
        self.titleStrLabel.textColor = textColor
        self.titleStrLabel.text = titleStr
        
        self.stepLabel.textColor = textColor
        self.stepLabel.text = stepStr
        
        self.backBtn.setImage(UIImage(named: backImageStr), for: .normal)
    }
    
    @objc func backAction(){
        if backBlock == nil {
            let vc = UIViewController.getCurrentViewController()?.navigationController!.viewControllers[1]
            UIViewController.getCurrentViewController()?.navigationController?.popToViewController(vc!, animated: true)
        }else {
            backBlock!()
        }
    }
}
