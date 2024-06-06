//
//  SMStep04Model.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/30.
//

import UIKit
import SwiftyJSON
class SMStep04Model: NSObject {
    var expects : SMStep04ExpectsModel?
    init(jsondata: JSON) {
        let expectsDic = jsondata["expects"]
        expects = SMStep04ExpectsModel(jsondata: expectsDic)
    }
}


class SMStep04ExpectsModel : NSObject {
    var bitand : String?
    var theyatArr = [SMStep04TheyatModel]()
    init(jsondata: JSON) {
        let theyat = jsondata["theyat"].arrayValue
        for theyatDic in theyat {
            let model : SMStep04TheyatModel = SMStep04TheyatModel(jsondata: theyatDic)
            theyatArr.append(model)
        }
    }
}

class SMStep04TheyatModel : NSObject {
    var natives : String?
    var specimen : String?
    var weren : String?
    var name_name : String?
    var mobile_name : String?
    var relation_name : String?
    var successful : String?
    var looksup : String?
    var fleshArr = [SMStep04FleshModel]()
    init(jsondata: JSON) {
        natives = jsondata["natives"].stringValue
        specimen = jsondata["specimen"].stringValue
        weren = jsondata["weren"].stringValue
        name_name = jsondata["name_name"].stringValue
        successful = jsondata["successful"].stringValue
        mobile_name = jsondata["mobile_name"].stringValue
        relation_name = jsondata["relation_name"].stringValue
        looksup = jsondata["looksup"].stringValue
        let flesh = jsondata["flesh"].arrayValue
        for fleshDic in flesh {
            let model : SMStep04FleshModel = SMStep04FleshModel(jsondata: fleshDic)
            fleshArr.append(model)
        }
    }
}

class SMStep04FleshModel : NSObject {
    var bigboy : String?
    var successful : String?
    init(jsondata: JSON) {
        bigboy = jsondata["bigboy"].stringValue
        successful = jsondata["successful"].stringValue
    }
}

