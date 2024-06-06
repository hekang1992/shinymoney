//
//  SMOrderModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/22.
//

import UIKit
import SwiftyJSON
class SMOrderModel: NSObject {
    var theyatArr = [SMOrderListModel]()
    init(jsondata: JSON) {
        let theyat = jsondata["theyat"].arrayValue
        for theyatDic in theyat {
            let model : SMOrderListModel = SMOrderListModel(jsondata: theyatDic)
            theyatArr.append(model)
        }
    }
}

class SMOrderListModel: NSObject {
    var stirring : String?
    var trade : String?
    var actually : String?
    var ordering : String?
    var ofsome : String?
    var known : String?
    var waited : String?
    var ahand : String?
    var merry : String?
    var offhand : String?
    var allfront : String?
    var teacher : String?
    var insteadof : String?
    var hissingClosed : String?
    var famousarchaeologist : String?
    var hewanted : String?
    var acorner : String?
    var andwhat : String?
    var loyalty : String?
    var werethemselves : String?
    var ofalmost : String?
    var dinahs : String?
    var hatched : String?
    var smile : String?
    var feasted : String?
    var noting : String?
    var wasspoken : String?
    var himstrictly : String?
    var utter : String?
    var excavated : String?

    init(jsondata: JSON) {
        stirring = jsondata["stirring"].stringValue
        trade = jsondata["trade"].stringValue
        hissingClosed = jsondata["hissingClosed"].stringValue
        actually = jsondata["actually"].stringValue
        ordering = jsondata["ordering"].stringValue
        ofsome = jsondata["ofsome"].stringValue
        known = jsondata["known"].stringValue
        waited = jsondata["waited"].stringValue
        ahand = jsondata["ahand"].stringValue
        merry = jsondata["merry"].stringValue
        offhand = jsondata["offhand"].stringValue
        allfront = jsondata["allfront"].stringValue
        teacher = jsondata["teacher"].stringValue
        insteadof = jsondata["insteadof"].stringValue
        famousarchaeologist = jsondata["famousarchaeologist"].stringValue
        hewanted = jsondata["hewanted"].stringValue
        acorner = jsondata["acorner"].stringValue
        andwhat = jsondata["andwhat"].stringValue
        loyalty = jsondata["loyalty"].stringValue
        werethemselves = jsondata["werethemselves"].stringValue
        ofalmost = jsondata["ofalmost"].stringValue
        dinahs = jsondata["dinahs"].stringValue
        hatched = jsondata["hatched"].stringValue
        smile = jsondata["smile"].stringValue
        feasted = jsondata["feasted"].stringValue
        noting = jsondata["noting"].stringValue
        wasspoken = jsondata["wasspoken"].stringValue
        himstrictly = jsondata["himstrictly"].stringValue
        utter = jsondata["utter"].stringValue
        excavated = jsondata["excavated"].stringValue
    }
}
