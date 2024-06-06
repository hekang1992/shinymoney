//
//  UIViewExt.swift
//  H2RideBossProject
//
//  Created by 李青 on 2024/3/13.
//

import UIKit
extension UIView {
    
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
        
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }
        
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }
        
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return frame.origin.x + frame.size.width / 2
        }
        set {
            frame.origin.x = newValue - frame.size.width / 2
        }
    }
        
    var centerY: CGFloat {
        get {
            return frame.origin.y + frame.size.height / 2
        }
        set {
            frame.origin.y = newValue - frame.size.height / 2
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
           let gradientLayer = CAGradientLayer()
           gradientLayer.frame = bounds
           gradientLayer.colors = colors.map { $0.cgColor }
           gradientLayer.startPoint = startPoint
           gradientLayer.endPoint = endPoint
           layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addShadow(color: UIColor = UIColor(hex: "a8a8a8"),
                      opacity: Float = 0.5,
                      offset: CGSize = CGSize(width: 2, height: 2),
                      radius: CGFloat = 4) {
           self.layer.shadowColor = color.cgColor
           self.layer.shadowOpacity = opacity
           self.layer.shadowOffset = offset
           self.layer.shadowRadius = radius
       }
}

