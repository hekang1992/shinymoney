//
//  SM_BillStyle01Cell.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/20.
//

import UIKit
import NNModule_swift
class SM_BillStyle01Cell: UITableViewCell {
    @IBOutlet weak var productIcon: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var borrowDateLabel: UILabel!
    @IBOutlet weak var loanAmountLabel: UILabel!
    @IBOutlet weak var loanAmountTitleLabel: UILabel!
    @IBOutlet weak var repaymentDateLabel: UILabel!
    @IBOutlet weak var repaymentDateTitleLabel: UILabel!
    @IBOutlet weak var bottomTipLabel: UILabel!
    @IBOutlet weak var rightArrowIcon: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var stateLabelWidthConstract: NSLayoutConstraint!
    var model : SMOrderListModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
        self.contentView.layer.cornerRadius = 8.0
        self.productIcon.layer.cornerRadius = 4.0
        
        self.stateLabel.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(stateOrderCheck))
        self.stateLabel.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func stateOrderCheck(){
        URLRouter.default.openRoute(model?.ordering ?? "")
    }
    
    func configData(model : SMOrderListModel){
        self.model = model
        self.productIcon.kf.setImage(with: URL(string: model.excavated ?? ""))
        self.productNameLabel.text = model.famousarchaeologist ?? ""
        self.borrowDateLabel.text = "Borrowing date:" + (model.himstrictly ?? "")
        self.loanAmountLabel.text = model.waited ?? ""
        self.loanAmountTitleLabel.text = model.feasted ?? ""
        self.repaymentDateLabel.text = model.noting ?? ""
        self.repaymentDateTitleLabel.text = model.dinahs ?? ""
        self.bottomTipLabel.text = model.smile ?? ""
        self.stateLabel.text = model.insteadof ?? ""
        if((model.werethemselves?.count ?? 0) * 9 > 60){
            self.stateLabelWidthConstract.constant = CGFloat((model.werethemselves?.count ?? 0) * 9)
        }else{
            self.stateLabelWidthConstract.constant = 60
        }
        if model.loyalty == "174" || model.loyalty == "180" || (model.loyalty == "151" && Int(model.hissingClosed ?? "0") ?? 0 > 0){
            self.bottomTipLabel.isHidden = false
            self.stateLabel.isHidden = false
            self.rightArrowIcon.isHidden = false
        }else{
            self.bottomTipLabel.isHidden = true
            self.stateLabel.isHidden = true
            self.rightArrowIcon.isHidden = true
        }
        
        if model.loyalty == "174" {
            self.arrowIcon.isHidden = true
            self.contentView.backgroundColor = UIColor(hex: "EE7105")
        }else if model.loyalty == "180"{
            self.arrowIcon.isHidden = true
            self.contentView.backgroundColor = UIColor(hex: "E13A5E")
        }else if (model.loyalty == "151" && Int(model.hissingClosed ?? "0") ?? 0 > 0) {
            self.arrowIcon.isHidden = true
            self.contentView.backgroundColor = UIColor(hex: "DE3AE1")
        }else{
            self.arrowIcon.isHidden = false
        }
        
        self.stateLabel.font = UIFont(name: "SFProDisplay-BlackItalic", size: 14)
        let attributes01: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
               
        let attributedString = NSAttributedString(string: self.stateLabel.text!, attributes: attributes01)
        self.stateLabel.attributedText = attributedString
    }
    
}
