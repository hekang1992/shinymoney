//
//  SM_BillChooseTypeListView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/20.
//

import UIKit

class SM_BillChooseTypeListView: UIView {
    let typeArr = ["All","Applying","Loan failure","Repayment","Overdue","Finished"]
    let typeStrArr = ["4","7","8","6","10","5"]
    var chooseTypeBlock : ((_ orderType : String,_ orderTypeName : String) -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "billChooseTypeBg")
        self.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        var lastView = UIView()
        for i in 0...typeArr.count - 1 {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            self.addSubview(view)
            view.mas_makeConstraints { make in
                make?.left.offset()(0)
                make?.right.offset()(0)
                if i == 0 {
                   make?.top.offset()(12)
                }else{
                    make?.top.equalTo()(lastView.mas_bottom)?.offset()(0)
                }
                make?.height.equalTo()((223 - 24)/6)
            }
            lastView = view
            
            let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseOrderType))
            view.tag = i
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tap)
            
            let typeLabel = UILabel()
            typeLabel.text = self.typeArr[i]
            typeLabel.font = UIFont(name: "SFProDisplay-Black", size: 16)
            typeLabel.textColor = UIColor(hex: "4D2717")
            self.addSubview(typeLabel)
            typeLabel.mas_makeConstraints { make in
                make?.center.equalTo()(view)
            }
            
            let attributes: [NSAttributedString.Key: Any] = [
                             .strokeColor: UIColor.white,
                             .foregroundColor: UIColor.black,
                             .strokeWidth: -6.0
         ]
            let attributedString = NSAttributedString(string: typeLabel.text!, attributes: attributes)
            typeLabel.attributedText = attributedString
        }
    }
    
    @objc func chooseOrderType(ges : UIGestureRecognizer){
        let tag = ges.view?.tag
        self.chooseTypeBlock?(self.typeStrArr[tag!],self.typeArr[tag!])
        self.removeFromSuperview()
    }
}
