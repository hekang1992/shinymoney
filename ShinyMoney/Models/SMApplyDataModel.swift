//
//  SMApplyDataModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/28.
//

import UIKit
import SwiftyJSON
class SMApplyDataModel: NSObject {
    var deadly : String?
    init(jsondata: JSON){
        deadly = jsondata["deadly"].stringValue
    }
}
