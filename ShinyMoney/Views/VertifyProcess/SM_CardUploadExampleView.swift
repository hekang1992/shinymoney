//
//  SM_CardUploadExampleView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/22.
//

import UIKit

class SM_CardUploadExampleView: UIView {
    var topBg : UIImageView!
    var middleBg : UIImageView!
    var gotItBtn : UIButton!
    var cardExampleImageView : UIImageView!
    var cardMistakeImageView01 : UIImageView!
    var cardMistakeImageView02 : UIImageView!
    var cardMistakeImageView03 : UIImageView!
    var gotItBlock : (() -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configData(cardNameStr : String){
        self.cardExampleImageView.kf.setImage(with: URL(string: "https://omdublending.com/mons/shimo/plansHated?bigboy=" + cardNameStr + "&" + "weren=1"))
        self.cardMistakeImageView01.kf.setImage(with: URL(string: "https://omdublending.com/mons/shimo/plansHated?bigboy=" + cardNameStr + "&" + "weren=2"))
        self.cardMistakeImageView02.kf.setImage(with: URL(string: "https://omdublending.com/mons/shimo/plansHated?bigboy=" + cardNameStr + "&" + "weren=3"))
        self.cardMistakeImageView03.kf.setImage(with: URL(string: "https://omdublending.com/mons/shimo/plansHated?bigboy=" + cardNameStr + "&" + "weren=4"))
    }
    
    func buildUI(){
        self.backgroundColor = UIColor(hex: "000000").withAlphaComponent(0.3)
        
        self.topBg = UIImageView()
        self.topBg.image = UIImage(named: "Example_topGreenBg")
        self.addSubview(self.topBg)
        self.topBg.mas_makeConstraints { make in
            make?.centerY.equalTo()(self)?.offset()(-110)
            make?.centerX.equalTo()(self)
        }
        self.setUpTopContentUI()
        
        self.middleBg = UIImageView()
        self.middleBg.image = UIImage(named: "Example_middlePurpleBg")
        self.addSubview(self.middleBg)
        self.middleBg.mas_makeConstraints { make in
            make?.top.equalTo()(self.topBg.mas_bottom)?.offset()(0)
            make?.centerX.equalTo()(self)
        }
        
        self.gotItBtn = UIButton(type: .custom)
        self.gotItBtn.layer.cornerRadius = 32
        self.gotItBtn.clipsToBounds = true
        self.gotItBtn.setTitle("Ok,I get it", for: .normal)
        self.gotItBtn.titleLabel?.font = UIFont(name: "SFProDisplay-BlackItalic", size: 20)
        let attributes: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
               
        let attributedString = NSAttributedString(string: self.gotItBtn.titleLabel?.text ?? "", attributes: attributes)
        self.gotItBtn.titleLabel?.attributedText = attributedString
        self.gotItBtn.setTitleColor(UIColor.black, for: .normal)
        self.gotItBtn.backgroundColor = UIColor(hex: "FCAA74")
        self.addSubview(self.gotItBtn)
        self.gotItBtn.mas_makeConstraints { make in
            make?.top.equalTo()(self.middleBg.mas_bottom)
            make?.centerX.equalTo()(self)
            make?.width.equalTo()(240)
            make?.height.equalTo()(64)
        }
        self.gotItBtn.addTarget(self, action: #selector(gotItAction), for: .touchUpInside)
        
        self.setUpMiddleContentUI()
    }
    
    func setUpTopContentUI(){
        let uploadExampleTitleLabel = UILabel()
        uploadExampleTitleLabel.textColor = UIColor.black
        uploadExampleTitleLabel.font = UIFont(name: "SFProDisplay-Black", size: 22)
        uploadExampleTitleLabel.text = "Upload example"
        let attributes: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
        let attributedString = NSAttributedString(string: uploadExampleTitleLabel.text ?? "", attributes: attributes)
        uploadExampleTitleLabel.attributedText = attributedString
        self.addSubview(uploadExampleTitleLabel)
        uploadExampleTitleLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.topBg.mas_top)?.offset()(88)
            make?.left.equalTo()(self.topBg.mas_left)?.offset()(30)
        }
        
        let plusBorderImageView = UIImageView()
        plusBorderImageView.image = UIImage(named: "Example_plusBorder")
        self.addSubview(plusBorderImageView)
        plusBorderImageView.mas_makeConstraints { make in
            make?.left.equalTo()(self.topBg.mas_left)?.offset()(20)
            make?.top.equalTo()(uploadExampleTitleLabel.mas_bottom)?.offset()(30)
        }
        
        self.cardExampleImageView = UIImageView()
        self.cardExampleImageView.backgroundColor = UIColor.white
        self.cardExampleImageView.layer.cornerRadius = 8.0
        self.cardExampleImageView.clipsToBounds = true
        self.addSubview((self.cardExampleImageView))
        self.cardExampleImageView.mas_makeConstraints { make in
            make?.left.equalTo()(plusBorderImageView.mas_left)?.offset()(14)
            make?.top.equalTo()(plusBorderImageView.mas_top)?.offset()(14)
            make?.width.equalTo()(156)
            make?.height.equalTo()(156*160/293)
        }
        
        let smileFaceIcon = UIImageView()
        smileFaceIcon.image = UIImage(named: "Example_smileFace")
        self.addSubview(smileFaceIcon)
        smileFaceIcon.mas_makeConstraints { make in
            make?.top.equalTo()(self.cardExampleImageView)
            make?.right.equalTo()(self.cardExampleImageView)
        }
        
        let firstStarIcon = UIImageView()
        firstStarIcon.image = UIImage(named: "Example_star")
        self.addSubview(firstStarIcon)
        firstStarIcon.mas_makeConstraints { make in
            make?.left.equalTo()(plusBorderImageView.mas_right)?.offset()(5)
            make?.top.equalTo()(plusBorderImageView.mas_top)?.offset()(22)
        }
        
        let firstLabel = UILabel()
        firstLabel.text = "Complete"
        firstLabel.textColor = UIColor.black
        firstLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 13)
        let attributes01: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -4.0
        ]
        let attributedString01 = NSAttributedString(string: firstLabel.text ?? "", attributes: attributes01)
        firstLabel.attributedText = attributedString01
        self.addSubview(firstLabel)
        firstLabel.mas_makeConstraints { make in
            make?.left.equalTo()(firstStarIcon.mas_right)?.offset()(4)
            make?.centerY.equalTo()(firstStarIcon)
        }
        
        let secondStarIcon = UIImageView()
        secondStarIcon.image = UIImage(named: "Example_star")
        self.addSubview(secondStarIcon)
        secondStarIcon.mas_makeConstraints { make in
            make?.left.equalTo()(plusBorderImageView.mas_right)?.offset()(5)
            make?.top.equalTo()(firstStarIcon.mas_bottom)?.offset()(10)
        }
        
        let secondLabel = UILabel()
        secondLabel.text = "Clear"
        secondLabel.textColor = UIColor.black
        secondLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 13)
        let attributes02: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -4.0
        ]
        let attributedString02 = NSAttributedString(string: secondLabel.text ?? "", attributes: attributes02)
        secondLabel.attributedText = attributedString02
        self.addSubview(secondLabel)
        secondLabel.mas_makeConstraints { make in
            make?.left.equalTo()(secondStarIcon.mas_right)?.offset()(4)
            make?.centerY.equalTo()(secondStarIcon)
        }
        
        let thirdStarIcon = UIImageView()
        thirdStarIcon.image = UIImage(named: "Example_star")
        self.addSubview(thirdStarIcon)
        thirdStarIcon.mas_makeConstraints { make in
            make?.left.equalTo()(plusBorderImageView.mas_right)?.offset()(5)
            make?.top.equalTo()(secondStarIcon.mas_bottom)?.offset()(10)
        }
        
        let thirdLabel = UILabel()
        thirdLabel.text = "Good lighting"
        thirdLabel.textColor = UIColor.black
        thirdLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 13)
        let attributes03: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -4.0
        ]
        let attributedString03 = NSAttributedString(string: thirdLabel.text ?? "", attributes: attributes03)
        thirdLabel.attributedText = attributedString03
        self.addSubview(thirdLabel)
        thirdLabel.mas_makeConstraints { make in
            make?.left.equalTo()(thirdStarIcon.mas_right)?.offset()(4)
            make?.centerY.equalTo()(thirdStarIcon)
        }
    }
    
    func setUpMiddleContentUI(){
        self.cardMistakeImageView02 = UIImageView()
        self.cardMistakeImageView02.backgroundColor = UIColor.white
        self.cardMistakeImageView02.layer.cornerRadius = 8.0
        self.cardMistakeImageView02.clipsToBounds = true
        self.addSubview(self.cardMistakeImageView02)
        self.cardMistakeImageView02.mas_makeConstraints { make in
            make?.top.equalTo()(self.middleBg.mas_top)?.offset()(30)
            make?.centerX.equalTo()(self.middleBg)
            make?.width.equalTo()(100)
            make?.height.equalTo()(55)
        }
        
        let cryFace02 = UIImageView()
        cryFace02.image = UIImage(named: "Example_cryingFace")
        self.addSubview(cryFace02)
        cryFace02.mas_makeConstraints { make in
            make?.top.equalTo()(self.cardMistakeImageView02)
            make?.right.equalTo()(self.cardMistakeImageView02)
        }
        
        let secondLabel = UILabel()
        secondLabel.text = "Occlusion"
        secondLabel.textColor = UIColor.black
        secondLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 12)
        let attributes01: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -4.0
        ]
        let attributedString01 = NSAttributedString(string: secondLabel.text ?? "", attributes: attributes01)
        secondLabel.attributedText = attributedString01
        self.addSubview(secondLabel)
        secondLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.cardMistakeImageView02)
            make?.top.equalTo()(self.cardMistakeImageView02.mas_bottom)?.offset()(14)
        }
        
        self.cardMistakeImageView01 = UIImageView()
        self.cardMistakeImageView01.backgroundColor = UIColor.white
        self.cardMistakeImageView01.layer.cornerRadius = 8.0
        self.cardMistakeImageView01.clipsToBounds = true
        self.addSubview(self.cardMistakeImageView01)
        self.cardMistakeImageView01.mas_makeConstraints { make in
            make?.top.equalTo()(self.middleBg.mas_top)?.offset()(30)
            make?.right.equalTo()(self.cardMistakeImageView02.mas_left)?.offset()(-4)
            make?.width.equalTo()(100)
            make?.height.equalTo()(55)
        }
        
        let firstLabel = UILabel()
        firstLabel.text = "Ambiguity"
        firstLabel.textColor = UIColor.black
        firstLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 12)
        let attributes: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -4.0
        ]
        let attributedString = NSAttributedString(string: firstLabel.text ?? "", attributes: attributes)
        firstLabel.attributedText = attributedString
        self.addSubview(firstLabel)
        firstLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.cardMistakeImageView01)
            make?.top.equalTo()(self.cardMistakeImageView01.mas_bottom)?.offset()(14)
        }
        
        let cryFace01 = UIImageView()
        cryFace01.image = UIImage(named: "Example_cryingFace")
        self.addSubview(cryFace01)
        cryFace01.mas_makeConstraints { make in
            make?.top.equalTo()(self.cardMistakeImageView01)
            make?.right.equalTo()(self.cardMistakeImageView01)
        }
        
        self.cardMistakeImageView03 = UIImageView()
        self.cardMistakeImageView03.backgroundColor = UIColor.white
        self.cardMistakeImageView03.layer.cornerRadius = 8.0
        self.cardMistakeImageView03.clipsToBounds = true
        self.addSubview(self.cardMistakeImageView03)
        self.cardMistakeImageView03.mas_makeConstraints { make in
            make?.top.equalTo()(self.middleBg.mas_top)?.offset()(30)
            make?.left.equalTo()(self.cardMistakeImageView02.mas_right)?.offset()(4)
            make?.width.equalTo()(100)
            make?.height.equalTo()(55)
        }
        
        let thirdLabel = UILabel()
        thirdLabel.text = "Poor light"
        thirdLabel.textColor = UIColor.black
        thirdLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 12)
        let attributes02: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -4.0
        ]
        let attributedString02 = NSAttributedString(string: thirdLabel.text ?? "", attributes: attributes02)
        thirdLabel.attributedText = attributedString02
        self.addSubview(thirdLabel)
        thirdLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.cardMistakeImageView03)
            make?.top.equalTo()(self.cardMistakeImageView03.mas_bottom)?.offset()(14)
        }
        
        let cryFace03 = UIImageView()
        cryFace03.image = UIImage(named: "Example_cryingFace")
        self.addSubview(cryFace03)
        cryFace03.mas_makeConstraints { make in
            make?.top.equalTo()(self.cardMistakeImageView03)
            make?.right.equalTo()(self.cardMistakeImageView03)
        }
    }
    
    @objc func gotItAction(){
        self.removeFromSuperview()
        self.gotItBlock?()
    }
}
