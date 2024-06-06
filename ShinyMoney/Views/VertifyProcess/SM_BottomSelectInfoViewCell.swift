//
//  SM_BottomSelectInfoViewCell.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/25.
//

import UIKit

class SM_BottomSelectInfoViewCell: UITableViewCell {
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var tickIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(tickIconImageStr : String){
        self.tickIcon.image = UIImage(named: tickIconImageStr)
    }
    
}
