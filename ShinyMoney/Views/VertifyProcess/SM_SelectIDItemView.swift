//
//  SM_SelectIDItemView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/26.
//

import UIKit
import Kingfisher
class SM_SelectIDItemView: UIView {
    var cardImageView : UIImageView!
    var cardNameLabel : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildUI(){
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = UIColor(hex: "F5F5F5")
        
        self.cardImageView = UIImageView()
        self.cardImageView.backgroundColor = UIColor(hex: "FFDAC2")
        self.cardImageView.layer.cornerRadius = 6.0
        self.addSubview(self.cardImageView)
        self.cardImageView.mas_makeConstraints { make in
            make?.left.offset()(10)
            make?.right.offset()(-10)
            make?.top.offset()(10)
            make?.height.equalTo()(70)
        }
        
        self.cardNameLabel = UILabel()
        self.cardNameLabel.textColor = UIColor(hex: "666666")
        self.cardNameLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.cardNameLabel)
        self.cardNameLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self)
            make?.top.equalTo()(self.cardImageView.mas_bottom)?.offset()(9)
        }
    }
    
    func configData(cardNameStr : String){
        self.cardNameLabel.text = cardNameStr
        self.cardImageView.kf.setImage(with: URL(string: "https://omdublending.com/mons/shimo/plansHated?bigboy=" + cardNameStr + "&" + "weren=1"))
    }
}
