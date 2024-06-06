//
//  SM_ProcessFillView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/18.
//

import UIKit

class SM_ProcessFillView: UIView {
    var titleStrLabel : UILabel!
    var fillView : UIView!
    var fillIcon : UIImageView!
    var fillTextField : UITextField!
    var currentSelectTitleStr : String?
    var currentSelectIndex : String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.titleStrLabel = UILabel()
        self.titleStrLabel.text = "Label"
        self.titleStrLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleStrLabel.textColor = UIColor(hex: "7AD2FC")
        self.addSubview(self.titleStrLabel)
        self.titleStrLabel.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.top.offset()(12)
        }
        
        self.fillView = UIView()
        self.fillView.layer.cornerRadius = 12
        self.fillView.backgroundColor = UIColor(hex: "7BD4FF").withAlphaComponent(0.1)
        self.fillView.layer.borderColor = UIColor(hex:  "7BD4FF").cgColor
        self.fillView.layer.borderWidth = 1.0
        self.addSubview(self.fillView)
        self.fillView.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.top.equalTo()(self.titleStrLabel.mas_bottom)?.offset()(8)
            make?.height.equalTo()(50)
        }
        
        self.fillIcon = UIImageView()
        self.fillIcon.image = UIImage(named: "vertifyEnterIcon")
        self.fillView.addSubview(self.fillIcon)
        self.fillIcon.mas_makeConstraints { make in
            make?.right.offset()(-20)
            make?.centerY.equalTo()(self.fillView)
            make?.width.equalTo()(18)
            make?.height.equalTo()(18)
        }
        
        self.fillTextField = UITextField()
        self.fillTextField.textColor = UIColor.black
        self.fillTextField.font = UIFont.boldSystemFont(ofSize: 14)
        self.fillTextField.placeholder = "Please choose"
        self.fillTextField.placeHolderColor = UIColor(hex: "CCCCCC")
        self.fillView.addSubview(self.fillTextField)
        self.fillTextField.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.right.equalTo()(self.fillIcon.mas_left)?.offset()(-12)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
    }
    
    func configData(styleColor : UIColor,fillIconName : String, titleStr : String) {
        self.fillView.backgroundColor = styleColor.withAlphaComponent(0.1)
        self.fillView.layer.borderColor = styleColor.cgColor
        self.fillIcon.image = UIImage(named: fillIconName)
        self.titleStrLabel.textColor = styleColor
        self.titleStrLabel.text = titleStr
    }
}
