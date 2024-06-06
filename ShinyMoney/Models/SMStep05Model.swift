//
//  SMStep05Model.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/5.
//

import UIKit
import SwiftyJSON
class SMStep05Model: NSObject {
    var callerArr = [SMStep05CallerModel]()
    init(jsondata: JSON) {
        let caller = jsondata["caller"].arrayValue
        for callerDic in caller {
            let model : SMStep05CallerModel = SMStep05CallerModel(jsondata: callerDic)
            callerArr.append(model)
        }
    }
}

class SMStep05CallerModel : NSObject {
    var callerArr = [SMStep05CallerCallerModel]()
    var bigboy : String?
    var loose : String?
    init(jsondata: JSON) {
        bigboy = jsondata["bigboy"].stringValue
        loose = jsondata["loose"].stringValue
        let caller = jsondata["caller"].arrayValue
        for callerDic in caller {
            let model : SMStep05CallerCallerModel = SMStep05CallerCallerModel(jsondata: callerDic)
            callerArr.append(model)
        }
    }
}

class SMStep05CallerCallerModel : NSObject {
    var discussing : String?
    var grasped : String?
    var sservant : String?
    var bigboy : String?
    var offer : String?
    var onsinging : String?
    var calledagain : String?
    var stroking : String?
    var arejust : String?
    var asclose : String?
    var forthem : String?
    var loose : String?
    var eatsproperlyArr = [SMStep05EatsproperlyrModel]()
    init(jsondata: JSON) {
        discussing = jsondata["discussing"].stringValue
        grasped = jsondata["grasped"].stringValue
        sservant = jsondata["sservant"].stringValue
        bigboy = jsondata["bigboy"].stringValue
        offer = jsondata["offer"].stringValue
        onsinging = jsondata["onsinging"].stringValue
        calledagain = jsondata["calledagain"].stringValue
        stroking = jsondata["stroking"].stringValue
        arejust = jsondata["arejust"].stringValue
        asclose = jsondata["asclose"].stringValue
        forthem = jsondata["forthem"].stringValue
        loose = jsondata["loose"].stringValue
        let eatsproperly = jsondata["eatsproperly"].arrayValue
        for eatsproperlyDic in eatsproperly {
            let model : SMStep05EatsproperlyrModel = SMStep05EatsproperlyrModel(jsondata: eatsproperlyDic)
            eatsproperlyArr.append(model)
        }
    }
}

class SMStep05EatsproperlyrModel : NSObject {
    var givinghim : String?
    var bigboy : String?
    var successful : String?
    init(jsondata: JSON) {
        givinghim = jsondata["givinghim"].stringValue
        bigboy = jsondata["bigboy"].stringValue
        successful = jsondata["successful"].stringValue
    }
}
