//
//  BossImageTextButton.swift
//  H2RideBossProject
//
//  Created by 李青 on 2024/3/26.
//

import UIKit

class SMImageTextButton: UIButton {
    private let spacing: CGFloat = 10.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        contentVerticalAlignment = .center
        contentHorizontalAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil && titleLabel != nil {
            let imageSize = imageView!.frame.size
            let titleSize = titleLabel!.frame.size
                    
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + spacing, bottom: 0, right: -titleSize.width - spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width - spacing, bottom: 0, right: imageSize.width + spacing)
            }
        }
}
