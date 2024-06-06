//
//  SMHomeInfoModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/26.
//

import UIKit
import SwiftyJSON
class SMHomeInfoModel: NSObject {
    var digging : diggingModel?  //LARGE_CARD
    var guide : guideModel? //BANNER
    var theyat : theyatModel? //PRODUCTLIST
    var thepicture : thepictureModel? //BANNER02
    init(jsondata: JSON){
        let diggingDic = jsondata["digging"]
        digging = diggingModel(jsondata: diggingDic)
        let guideDic = jsondata["guide"]
        guide = guideModel(jsondata: guideDic)
        let theyatDic = jsondata["theyat"]
        theyat = theyatModel(jsondata: theyatDic)
        let thepictureDic = jsondata["thepicture"]
        thepicture = thepictureModel(jsondata: thepictureDic)
    }
}

class diggingModel : NSObject {
    var dragged : draggedModel?
    var bigboy : String?
    init(jsondata: JSON){
        bigboy = jsondata["bigboy"].stringValue
        let draggedDic = jsondata["dragged"]
        dragged = draggedModel(jsondata: draggedDic)
    }
}

class draggedModel : NSObject {
    var billshowed : String?
    var oldtemple : String?
    var thebig : String?
    var discovered : String?
    var werethemselves : String?
    var excavated : String?
    var crowded : String?
    var postcards : String?
    var andover : String?
    var crash : String?
    var packet : String?
    init(jsondata: JSON){
        billshowed = jsondata["billshowed"].stringValue
        oldtemple = jsondata["oldtemple"].stringValue
        thebig = jsondata["thebig"].stringValue
        discovered = jsondata["discovered"].stringValue
        werethemselves = jsondata["werethemselves"].stringValue
        excavated = jsondata["excavated"].stringValue
        crowded = jsondata["crowded"].stringValue
        postcards = jsondata["postcards"].stringValue
        andover = jsondata["andover"].stringValue
        crash = jsondata["crash"].stringValue
        packet = jsondata["packet"].stringValue
    }
}

class guideModel : NSObject {
    var draggedArr = [guideDraggedModel]()
    var bigboy : String?
    init(jsondata: JSON){
        bigboy = jsondata["bigboy"].stringValue
        let dragged = jsondata["dragged"].arrayValue
        for draggedDic in dragged {
            let model : guideDraggedModel = guideDraggedModel(jsondata: draggedDic)
            draggedArr.append(model)
        }
    }
}

class guideDraggedModel : NSObject {
    var mysnake : String?
    var beneath : String?
    var theysaw : String?
    var loose : String?
    var deadly : String?
    var local : String?
    init(jsondata: JSON){
        mysnake = jsondata["mysnake"].stringValue
        beneath = jsondata["beneath"].stringValue
        theysaw = jsondata["theysaw"].stringValue
        loose = jsondata["loose"].stringValue
        deadly = jsondata["deadly"].stringValue
        local = jsondata["local"].stringValue
    }
}

class theyatModel : NSObject {
    var bigboy : String?
    var theyatArr = [theyatListModel]()
    init(jsondata: JSON){
        bigboy = jsondata["bigboy"].stringValue
        let dragged = jsondata["dragged"].arrayValue
        for draggedDic in dragged {
            let model : theyatListModel = theyatListModel(jsondata: draggedDic)
            theyatArr.append(model)
        }
    }
}

class LoanTheyatModel : NSObject {
    var cooking : String?
    var theyatArr = [theyatListModel]()
    init(jsondata: JSON){
        cooking = jsondata["cooking"].stringValue
        let theyat = jsondata["theyat"].arrayValue
        for theyatDic in theyat {
            let model : theyatListModel = theyatListModel(jsondata: theyatDic)
            theyatArr.append(model)
        }
    }
}


class theyatListModel : NSObject {
    var allfront : String?
    var famousarchaeologist : String?
    var productDesc : String?
    var itwhile : String?
    var cultivated : String?
    var isCopyPhone : String?
    var loanTermText : String?
    var packet : String?
    var loan_rate : String?
    var guessed : String?
    var trembling : String?
    var buttonExplain : String?
    var buttonStatus : String?
    var crash : String?
    var postcards : String?
    var deadly : String?
    var discovered : String?
    var thumping : String?
    var excavated : String?
    var productTags : [JSON]?
    var werethemselves : String?
    var oldtemple : String?
    var ofalmost : String?
    var todayClicked : String?
    var amountMax : String?
    var titleText : String?
    var crowded : String?
    var todayApplyNum : String?
    var buttoncolor : String?
    var gestured : String?
    init(jsondata: JSON){
        allfront = jsondata["famousarchaeologist"].stringValue
        famousarchaeologist = jsondata["famousarchaeologist"].stringValue
        productDesc = jsondata["productDesc"].stringValue
        itwhile = jsondata["itwhile"].stringValue
        cultivated = jsondata["cultivated"].stringValue
        isCopyPhone = jsondata["isCopyPhone"].stringValue
        loanTermText = jsondata["loanTermText"].stringValue
        packet = jsondata["packet"].stringValue
        loan_rate = jsondata["loan_rate"].stringValue
        guessed = jsondata["guessed"].stringValue
        trembling = jsondata["trembling"].stringValue
        buttonExplain = jsondata["buttonExplain"].stringValue
        buttonStatus = jsondata["buttonStatus"].stringValue
        crash = jsondata["crash"].stringValue
        postcards = jsondata["postcards"].stringValue
        deadly = jsondata["deadly"].stringValue
        discovered = jsondata["discovered"].stringValue
        thumping = jsondata["thumping"].stringValue
        excavated = jsondata["excavated"].stringValue
        productTags = jsondata["productTags"].arrayValue
        werethemselves = jsondata["werethemselves"].stringValue
        oldtemple = jsondata["oldtemple"].stringValue
        ofalmost = jsondata["ofalmost"].stringValue
        todayClicked = jsondata["todayClicked"].stringValue
        amountMax = jsondata["amountMax"].stringValue
        titleText = jsondata["titleText"].stringValue
        crowded = jsondata["crowded"].stringValue
        todayApplyNum = jsondata["todayApplyNum"].stringValue
        buttoncolor = jsondata["buttoncolor"].stringValue
        gestured = jsondata["buttoncolor"].stringValue
    }
}

class thepictureModel : NSObject {
    var bigboy : String?
    var dragged : String?
    var theyatArr = [thepictureListModel]()
    init(jsondata: JSON){
        bigboy = jsondata["bigboy"].stringValue
        let dragged = jsondata["dragged"].arrayValue
        for draggedDic in dragged {
            let model : thepictureListModel = thepictureListModel(jsondata: draggedDic)
            theyatArr.append(model)
        }
    }
}

class thepictureListModel : NSObject {
    var mysnake : String?
    var insects : String?
    var loose : String?
    var beneath : String?
    var allfront : String?
    var deadly : String?
    var theysaw : String?
    var appeared : String?
    var local : String?
    init(jsondata: JSON){
        mysnake = jsondata["mysnake"].stringValue
        insects = jsondata["insects"].stringValue
        loose = jsondata["loose"].stringValue
        beneath = jsondata["beneath"].stringValue
        allfront = jsondata["allfront"].stringValue
        deadly = jsondata["deadly"].stringValue
        theysaw = jsondata["theysaw"].stringValue
        appeared = jsondata["appeared"].stringValue
        local = jsondata["local"].stringValue
    }
}

