//
//  SMCardInfoModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/29.
//

import UIKit
import SwiftyJSON
class SMCardInfoModel: NSObject {
    var hethinks : String?
    var successful : String?
    var deadly : String?
    var abedroom : String?
    var wrinkled : String?
    var horrid : String?
    var inhis : String?
    var pretended : String?
    init(jsondata: JSON){
        hethinks = jsondata["hethinks"].stringValue
        successful = jsondata["successful"].stringValue
        deadly = jsondata["deadly"].stringValue
        abedroom = jsondata["abedroom"].stringValue
        wrinkled = jsondata["wrinkled"].stringValue
        horrid = jsondata["horrid"].stringValue
        inhis = jsondata["inhis"].stringValue
        pretended = jsondata["pretended"].stringValue
    }
}
