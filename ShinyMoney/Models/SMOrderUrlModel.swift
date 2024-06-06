//
//  SMOrderUrlModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/5.
//

import UIKit
import SwiftyJSON
class SMOrderUrlModel: NSObject {
    var deadly : String?
    init(jsondata: JSON) {
        deadly = jsondata["deadly"].stringValue
    }
}
