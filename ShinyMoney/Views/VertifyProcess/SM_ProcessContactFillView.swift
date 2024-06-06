//
//  SM_ProcessContactFillView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/22.
//

import UIKit

class SM_ProcessContactFillView: UIView {
    var contactNumLabelView : UIView!
    var contactNumLabel : UILabel!
    var relationShipFillView : SM_ProcessFillView!
    var phoneNumberFillView : SM_ProcessFillView!
    var currentSelectTitleStr : String?
    var currentSelectIndex : String?
    var nameStr : String?
    var phoneStr : String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.backgroundColor = UIColor.clear
        
        self.contactNumLabelView = UIView()
        self.contactNumLabelView.backgroundColor = UIColor(hex: "000000")
        self.contactNumLabelView.layer.cornerRadius = 16
        self.contactNumLabelView.clipsToBounds = true
        self.addSubview(self.contactNumLabelView)
        self.contactNumLabelView.mas_makeConstraints { make in
            make?.height.equalTo()(32)
            make?.width.equalTo()(220)
            make?.top.offset()(30)
            make?.centerX.equalTo()(self)
        }
        
        self.contactNumLabel = UILabel()
        self.contactNumLabel.text = "Emergency Contact1"
        self.contactNumLabel.textColor = UIColor.white
        self.contactNumLabel.font = UIFont.systemFont(ofSize: 14)
        self.contactNumLabelView.addSubview(self.contactNumLabel)
        self.contactNumLabel.mas_makeConstraints { make in
            make?.center.equalTo()(self.contactNumLabelView)
        }
        
        let leftStarIcon = UIImageView()
        leftStarIcon.image = UIImage(named: "vertify_star")
        self.contactNumLabelView.addSubview(leftStarIcon)
        leftStarIcon.mas_makeConstraints { make in
            make?.centerY.equalTo()(contactNumLabelView)
            make?.right.equalTo()(self.contactNumLabel.mas_left)?.offset()(-3)
        }
        
        let rightStarIcon = UIImageView()
        rightStarIcon.image = UIImage(named: "vertify_star")
        self.contactNumLabelView.addSubview(rightStarIcon)
        rightStarIcon.mas_makeConstraints { make in
            make?.centerY.equalTo()(contactNumLabelView)
            make?.left.equalTo()(self.contactNumLabel.mas_right)?.offset()(3)
        }
        
        self.relationShipFillView = SM_ProcessFillView(frame: CGRectZero)
        self.relationShipFillView.configData(styleColor: UIColor(hex: "A7E82B"), fillIconName: "vertifyPulldownIcon04", titleStr: "Relationship")
        self.relationShipFillView.fillTextField.placeholder = "Please choose"
        self.addSubview(self.relationShipFillView)
        self.relationShipFillView.mas_makeConstraints { make in
            make?.top.equalTo()(self.contactNumLabelView.mas_bottom)?.offset()(14)
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(96)
        }
        
        self.phoneNumberFillView = SM_ProcessFillView(frame: CGRectZero)
        self.phoneNumberFillView.configData(styleColor: UIColor(hex: "A7E82B"), fillIconName: "vertifyPulldownIcon04", titleStr: "Phone Number")
        self.phoneNumberFillView.fillTextField.placeholder = "Please choose"
        self.addSubview(self.phoneNumberFillView)
        self.phoneNumberFillView.mas_makeConstraints { make in
            make?.top.equalTo()(self.relationShipFillView.mas_bottom)?.offset()(8)
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(96)
        }
    }
}
