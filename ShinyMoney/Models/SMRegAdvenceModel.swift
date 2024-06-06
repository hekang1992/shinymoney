//
//  SMRegAdvenceModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/29.
//

import UIKit
import SwiftyJSON
class SMRegAdvenceModel: NSObject {
    var whofelt : String?
    var bigboy : String?
    var indisdain : String?
    init(jsondata: JSON){
        whofelt = jsondata["whofelt"].stringValue
        bigboy = jsondata["bigboy"].stringValue
        indisdain = jsondata["indisdain"].stringValue
    }
}
