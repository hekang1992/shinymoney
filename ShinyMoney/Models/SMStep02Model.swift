//
//  SMStep02Model.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/29.
//

import UIKit
import SwiftyJSON
class SMStep02Model: NSObject {
    var callerArr = [SMStep02CallerModel]()
    init(jsondata: JSON){
        let caller = jsondata["caller"].arrayValue
        for callerDic in caller {
            let model : SMStep02CallerModel = SMStep02CallerModel(jsondata: callerDic)
            callerArr.append(model)
        }
    }
}

class SMStep02CallerModel : NSObject {
    var asclose : String?
    var hehad : String?
    var grasped : String?
    var forthem : String?
    var loose : String?
    var calledagain : String?
    var arejust : String?
    var bigboy : String?
    var onsinging : String?
    var stroking : String?
    var crash : String?
    var sservant : String?
    var offer : String?
    var eatsproperlyArr = [SMStep02EatsproperlyModel]()
    init(jsondata: JSON){
        asclose = jsondata["asclose"].stringValue
        hehad = jsondata["hehad"].stringValue
        grasped = jsondata["grasped"].stringValue
        forthem = jsondata["forthem"].stringValue
        loose = jsondata["loose"].stringValue
        calledagain = jsondata["calledagain"].stringValue
        arejust = jsondata["arejust"].stringValue
        bigboy = jsondata["bigboy"].stringValue
        onsinging = jsondata["onsinging"].stringValue
        stroking = jsondata["stroking"].stringValue
        crash = jsondata["crash"].stringValue
        sservant = jsondata["sservant"].stringValue
        offer = jsondata["offer"].stringValue
        let eatsproperly = jsondata["eatsproperly"].arrayValue
        for eatsproperlyDic in eatsproperly {
            let model : SMStep02EatsproperlyModel = SMStep02EatsproperlyModel(jsondata: eatsproperlyDic)
            eatsproperlyArr.append(model)
        }
    }
}

class SMStep02EatsproperlyModel : NSObject {
    var bigboy : String?
    var successful : String?
    var eatsproperlyArr = [SMStep02EatsproperlyModel]()
    init(jsondata: JSON){
        bigboy = jsondata["bigboy"].stringValue
        successful = jsondata["successful"].stringValue
        let eatsproperly = jsondata["eatsproperly"].arrayValue
        for eatsproperlyDic in eatsproperly {
            let model : SMStep02EatsproperlyModel = SMStep02EatsproperlyModel(jsondata: eatsproperlyDic)
            eatsproperlyArr.append(model)
        }
    }
}
