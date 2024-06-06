//
//  SMProductDetailModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/28.
//

import UIKit
import SwiftyJSON
class SMProductDetailModel: NSObject {
    var supplying : SMSupplyingModel?
    var trackdown : SMtrackdownModel?
    var smugglingArr = [SMSmugglingModel]()
    init(jsondata: JSON){
        let supplyingDic = jsondata["supplying"]
        supplying = SMSupplyingModel(jsondata: supplyingDic)
        let trackdownDic = jsondata["trackdown"]
        trackdown = SMtrackdownModel(jsondata: trackdownDic)
        let smuggling = jsondata["smuggling"].arrayValue
        for smugglingDic in smuggling {
            let model : SMSmugglingModel = SMSmugglingModel(jsondata: smugglingDic)
            smugglingArr.append(model)
        }
    }
}

class SMSupplyingModel: NSObject {
    var deadly : String?
    var stroking : String?
    var loose : String?
    var trusthim : String?
    var bigboy : String?
    init(jsondata: JSON){
        deadly = jsondata["deadly"].stringValue
        stroking = jsondata["stroking"].stringValue
        loose = jsondata["loose"].stringValue
        trusthim = jsondata["trusthim"].stringValue
        bigboy = jsondata["bigboy"].stringValue
    }
}

class SMSmugglingModel: NSObject {
    var loose : String?
    var deadly : String?
    var trusthim : String?
    var stroking : String?
    var price : String?
    var grasped : String?
    var offer : String?
    var forthem : String?
    var forbiscuits : String?
    var illegally : String?
    var bigboy : String?
    var spying : String?
    init(jsondata: JSON){
        loose = jsondata["loose"].stringValue
        deadly = jsondata["deadly"].stringValue
        trusthim = jsondata["trusthim"].stringValue
        stroking = jsondata["stroking"].stringValue
        price = jsondata["price"].stringValue
        grasped = jsondata["grasped"].stringValue
        offer = jsondata["offer"].stringValue
        forthem = jsondata["forthem"].stringValue
        forbiscuits = jsondata["forbiscuits"].stringValue
        illegally = jsondata["illegally"].stringValue
        bigboy = jsondata["bigboy"].stringValue
        spying = jsondata["spying"].stringValue
    }
}

class SMtrackdownModel : NSObject {
    var stirring : String?
    init(jsondata: JSON){
        stirring = jsondata["stirring"].stringValue
    }
}
