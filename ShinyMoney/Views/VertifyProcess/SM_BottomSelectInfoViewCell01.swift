//
//  SM_BottomSelectInfoViewCell01.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/25.
//

import UIKit

class SM_BottomSelectInfoViewCell01: UITableViewCell {
    @IBOutlet weak var tickIcon: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
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
