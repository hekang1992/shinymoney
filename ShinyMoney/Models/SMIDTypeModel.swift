//
//  SMIDTypeModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/28.
//

import UIKit
import SwiftyJSON
class SMIDTypeModel: NSObject {
    var contact : [JSON]?
    var films : SMCardFilmsModel?
    var comehome : String?
    var deadly : String?
    init(jsondata: JSON){
        contact = jsondata["contact"].arrayValue
        let filmsDic = jsondata["films"]
        films = SMCardFilmsModel(jsondata: filmsDic)
        comehome = jsondata["comehome"].stringValue
        deadly = jsondata["deadly"].stringValue
    }
}

class SMCardFilmsModel: NSObject {
    var isextremely : String?
    var grasped : String?
    var deadly : String?
    init(jsondata: JSON){
        isextremely = jsondata["isextremely"].stringValue
        grasped = jsondata["grasped"].stringValue
        deadly = jsondata["deadly"].stringValue
    }
}

