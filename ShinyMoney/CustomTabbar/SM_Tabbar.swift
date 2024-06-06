//
//  SM_Tabbar.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/8.
//

import UIKit

class SM_Tabbar: UIView {
    var billBtn : UIButton!
    var homeBtn : UIButton!
    var accountBtn : UIButton!
    var currentSelectIndex : Int! = 1
    var tabbarSelectBlock : ((_ currentSelectIndex : Int)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.backgroundColor = UIColor(hex: "383838")
        
        self.homeBtn = UIButton(type: .custom)
        self.homeBtn.tag = 102
        self.homeBtn.isSelected = true
        self.homeBtn.addTarget(self, action: #selector(selectItemAction), for: .touchUpInside)
        self.homeBtn.setImage(UIImage(named: "home_normal"), for: .normal)
        self.homeBtn.setImage(UIImage(named: "home_selected"), for: .selected)
        self.homeBtn.setTitle("", for: .normal)
        self.homeBtn.backgroundColor = UIColor.clear
        self.addSubview(self.homeBtn)
        self.homeBtn.mas_makeConstraints { make in
            make?.top.offset()(13)
            make?.height.equalTo()(60)
            make?.width.equalTo()(60)
            make?.centerX.equalTo()(self)
        }
        
        self.billBtn = UIButton(type: .custom)
        self.billBtn.tag = 101
        self.billBtn.addTarget(self, action: #selector(selectItemAction), for: .touchUpInside)
        self.billBtn.setImage(UIImage(named: "bill_normal"), for: .normal)
        self.billBtn.setImage(UIImage(named: "bill_selected"), for: .selected)
        self.billBtn.setTitle("", for: .normal)
        self.billBtn.backgroundColor = UIColor.clear
        self.addSubview(self.billBtn)
        self.billBtn.mas_makeConstraints { make in
            make?.width.equalTo()(60)
            make?.height.equalTo()(60)
            make?.left.offset()(screenWidth/4-30)
            make?.centerY.equalTo()(self.homeBtn)
        }
        
        self.accountBtn = UIButton(type: .custom)
        self.accountBtn.tag = 103
        self.accountBtn.addTarget(self, action: #selector(selectItemAction), for: .touchUpInside)
        self.accountBtn.setImage(UIImage(named: "account_normal"), for: .normal)
        self.accountBtn.setImage(UIImage(named: "account_selected"), for: .selected)
        self.accountBtn.setTitle("", for: .normal)
        self.accountBtn.backgroundColor = UIColor.clear
        self.addSubview(self.accountBtn)
        self.accountBtn.mas_makeConstraints { make in
            make?.width.equalTo()(60)
            make?.height.equalTo()(60)
            make?.left.offset()(screenWidth/4*3-30)
            make?.centerY.equalTo()(self.homeBtn)
        }
    }
    
    @objc func selectItemAction(button : UIButton){
        let tag = button.tag
        switch tag {
        case 101:
            self.currentSelectIndex = 0
            self.refreshTabbarStyle()
            break
        case 102:
            self.currentSelectIndex = 1
            self.refreshTabbarStyle()
            break
        case 103:
            self.currentSelectIndex = 2
            self.refreshTabbarStyle()
            break
        default:
            self.currentSelectIndex = 1
            self.refreshTabbarStyle()
        }
    }
    
    func refreshTabbarStyle(){
        if self.currentSelectIndex == 0 {
            if SMUserModel.checkIsLogin() == false {
                return
            }
            self.billBtn.isSelected = true
            self.homeBtn.isSelected = false
            self.accountBtn.isSelected = false
            
            self.billBtn.mas_remakeConstraints { make in
                make?.width.equalTo()(100)
                make?.height.equalTo()(60)
                make?.left.offset()(screenWidth/4-50)
                make?.centerY.equalTo()(self.homeBtn)
            }
            
            self.accountBtn.mas_remakeConstraints { make in
                make?.width.equalTo()(60)
                make?.height.equalTo()(60)
                make?.left.offset()(screenWidth/4*3-30)
                make?.centerY.equalTo()(self.homeBtn)
            }
        }else if self.currentSelectIndex == 1 {
            self.billBtn.isSelected = false
            self.homeBtn.isSelected = true
            self.accountBtn.isSelected = false
            self.billBtn.mas_remakeConstraints { make in
                make?.width.equalTo()(60)
                make?.height.equalTo()(60)
                make?.left.offset()(screenWidth/4-30)
                make?.centerY.equalTo()(self.homeBtn)
            }
            
            self.accountBtn.mas_remakeConstraints { make in
                make?.width.equalTo()(60)
                make?.height.equalTo()(60)
                make?.left.offset()(screenWidth/4*3-30)
                make?.centerY.equalTo()(self.homeBtn)
            }
        }else{
            self.billBtn.isSelected = false
            self.homeBtn.isSelected = false
            self.accountBtn.isSelected = true
            self.billBtn.mas_remakeConstraints { make in
                make?.width.equalTo()(60)
                make?.height.equalTo()(60)
                make?.left.offset()(screenWidth/4-30)
                make?.centerY.equalTo()(self.homeBtn)
            }
            
            self.accountBtn.mas_remakeConstraints { make in
                make?.width.equalTo()(100)
                make?.height.equalTo()(60)
                make?.left.offset()(screenWidth/4*3-50)
                make?.centerY.equalTo()(self.homeBtn)
            }
        }
        self.tabbarSelectBlock?(self.currentSelectIndex)
    }
}
