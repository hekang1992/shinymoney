//
//  SM_ProductCell.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/21.
//

import UIKit

class SM_ProductCell: UITableViewCell {
    @IBOutlet weak var productIcon: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var maxAmountTitleLabel: UILabel!
    @IBOutlet weak var maxAmountLabel: UILabel!
    @IBOutlet weak var upArrow: UIImageView!
    @IBOutlet weak var tipBgView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var btnBgImageView: UIImageView!
    @IBOutlet weak var btnLabel: UILabel!
    @IBOutlet weak var topBgImageView: UIImageView!
    @IBOutlet weak var tipBottomConstract: NSLayoutConstraint!
    @IBOutlet weak var tipLabelTopConstract: NSLayoutConstraint!
    @IBOutlet weak var tipLabelBottomConstract: NSLayoutConstraint!
    var model : theyatListModel?
    var starIcon : UIImageView!
    var applyBlock : ((_ model : theyatListModel) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productIcon.layer.cornerRadius = 6
        self.tipBgView.layer.cornerRadius = 4.0
        
        self.starIcon = UIImageView()
        self.starIcon.image = UIImage(named: "homeStar")
        self.contentView.addSubview(self.starIcon)
        self.starIcon.mas_makeConstraints { make in
            make?.width.equalTo()(16)
            make?.height.equalTo()(16)
            make?.left.equalTo()(self.topBgImageView)?.offset()(38/323*(screenWidth - 52))
            make?.top.equalTo()(self.topBgImageView)?.offset()(20/323*(screenWidth - 52))
        }
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(applyAction))
        self.btnLabel.isUserInteractionEnabled = true
        self.btnLabel.addGestureRecognizer(tap)
    }
    
    @objc func applyAction(){
        if self.model != nil {
            self.applyBlock?(self.model!)
        }
    }
    
    func configData(model : theyatListModel){
        self.model = model
        self.productIcon.kf.setImage(with: URL(string: model.excavated ?? ""))
        self.productLabel.text = model.famousarchaeologist ?? ""
        self.maxAmountTitleLabel.text = (model.oldtemple ?? "") + ":"
        self.maxAmountLabel.text = model.discovered ?? ""
        if model.itwhile?.count == 0 {
            self.upArrow.isHidden = true
            self.tipLabel.isHidden = true
            self.tipBgView.isHidden = true
            self.topBgImageView.image = UIImage(named: "homeProductTopBg_low")
            self.tipLabelTopConstract.constant = 0
            self.tipLabelBottomConstract.constant = 0
            self.tipLabel.mas_remakeConstraints { make in
                make?.height.equalTo()(0)
                make?.width.equalTo()(0)
                make?.left.offset()(12)
                make?.right.offset()(-12)
            }
        }else{
            self.upArrow.isHidden = false
            self.tipLabel.isHidden = false
            self.tipBgView.isHidden = false
            self.topBgImageView.image = UIImage(named: "homeProductTopBg")
            self.tipLabelTopConstract.constant = 8
            self.tipLabelBottomConstract.constant = 8
            self.tipLabel.mas_remakeConstraints { make in
                make?.top.offset()(8)
                make?.bottom.offset()(8)
                make?.left.offset()(12)
                make?.right.offset()(-12)
            }
        }
        self.tipLabel.text = model.itwhile  ?? ""
        if model.guessed == "Recommend" {
            self.starIcon.isHidden = false
        }else{
            self.starIcon.isHidden = true
        }
        self.btnLabel.text = model.werethemselves ?? ""
        
        self.btnLabel.font = UIFont(name: "SFProDisplay-Black", size: 20)
        let attributes01: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
               
        let attributedString = NSAttributedString(string: self.btnLabel.text!, attributes: attributes01)
        self.btnLabel.attributedText = attributedString
        
        if model.cultivated == "1" {
            self.btnBgImageView.image = UIImage(named: "homeProductBtnBg_Green")
        }else if model.cultivated == "2" {
            self.btnBgImageView.image = UIImage(named: "homeProductBtnBg_Orange")
        }else if model.cultivated == "3" {
            self.btnBgImageView.image = UIImage(named: "homeProductBtnBg_Gray")
        }else{
            self.btnBgImageView.image = UIImage(named: "homeProductBtnBg_Red")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
