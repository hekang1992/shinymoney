//
//  UIColorExt.swift
//  H2RideBossProject
//
//  Created by Alex on 2024/3/20.
//

import UIKit

extension UIColor {
    
    //水平渐变
    static func horizontalGradientFromColor(_ fromColor: UIColor, toColor: UIColor, withWidth width: CGFloat) -> UIColor {
        let size = CGSize(width: width, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError("Failed to get current graphics context")
        }
          
        let colors = [fromColor.cgColor, toColor.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)!
          
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: width, y: 0), options: [])
          
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
          
        return UIColor(patternImage: image!)
    }
    
    //垂直渐变
    static func verticalGradientFromColor(_ fromColor: UIColor, toColor: UIColor, withHeight height: CGFloat) -> UIColor {
        let size = CGSize(width: 1, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError("Failed to get current graphics context")
        }
          
        let colors = [fromColor.cgColor, toColor.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)!
          
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: height), options: [])
          
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
          
        return UIColor(patternImage: image!)
    }
    
}
