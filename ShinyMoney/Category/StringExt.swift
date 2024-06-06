//
//  StringExt.swift
//  H2RideBossProject
//
//  Created by 李青 on 2024/3/25.
//
import UIKit

extension String {
    func width(withFont font: UIFont) -> CGFloat {
         let fontAttributes = [NSAttributedString.Key.font: font]
         let size = self.size(withAttributes: fontAttributes)
         return size.width
     }
    
    func isContainChinese() -> Bool {
        let length = self.count
        for i in 0..<length {
            let range = NSRange(location: i, length: 1)
            let subString = (self as NSString).substring(with: range)
            let cString = subString.cString(using: .utf8)
            if cString?.count == 3 {
                return true
            }
        }
        return false
    }
    
    func urlAllowChinese() -> String {
        let ret = self.isContainChinese()
        if ret {
            return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
        }
        return self
    }
}
