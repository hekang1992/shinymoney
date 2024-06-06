//
//  SMEnvironmentModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/23.
//

import UIKit
import SwiftyJSON
class SMEnvironmentModel: NSObject {
    var hasgone : String?
    init(jsondata: JSON){
        hasgone = jsondata["hasgone"].stringValue
    }
}
