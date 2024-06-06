//
//  SMGoogleUploadModel.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/24.
//

import UIKit
import SwiftyJSON
class SMGoogleUploadModel: NSObject {
    var softly : String?
    var explainedmore : String?
    init(jsondata: JSON){
        softly = jsondata["softly"].stringValue
        explainedmore = jsondata["explainedmore"].stringValue
    }
}
