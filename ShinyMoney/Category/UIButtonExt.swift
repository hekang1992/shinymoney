//
//  UIButtonExt.swift
//  H2RideBossProject
//
//  Created by 李青 on 2024/3/18.
//

import UIKit

extension UIButton {
    func setCommonGradientBackgroundImage(imageName: String = "homeBtnBg", forState state: UIControl.State) {
        if let backImage = UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5), resizingMode: .stretch) {
            setBackgroundImage(backImage, for: state)
        }
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func widthForTitle(title: String, sizefont: CGFloat) -> CGFloat {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = titleLabel.font.withSize(sizefont)
            titleLabel.sizeToFit()
            return titleLabel.frame.width
    }
    
    func widthForTitle(title: String, titleFont: UIFont) -> CGFloat {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = titleFont
            titleLabel.sizeToFit()
            return titleLabel.frame.width
    }
    
    func heightForTitle(title: String, titleFont: UIFont) -> CGFloat {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = titleFont
            titleLabel.sizeToFit()
            return titleLabel.frame.height
    }
}
