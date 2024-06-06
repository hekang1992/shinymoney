//
//  SMCityLocationModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/24.
//

import UIKit
import SwiftyJSON
class SMCityLocationModel: NSObject {
    var theyatArr = [SMCityLocationModel]()
    var crash : String?
    var successful : String?
    init(jsondata: JSON){
        let theyat = jsondata["theyat"].arrayValue
        for theyatDic in theyat {
            let model : SMCityLocationModel = SMCityLocationModel(jsondata: theyatDic)
            theyatArr.append(model)
        }
        crash = jsondata["crash"].stringValue
        successful = jsondata["successful"].stringValue
    }
}
