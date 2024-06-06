//
//  LendEasy_apiModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/9/18.
//

import UIKit
import SwiftyJSON
class SMDataModel: NSObject{
    var onsinging : Int?
    var heardhalf : String?
    var ended : JSON? = []
    
    init(jsondata:JSON){
        onsinging = jsondata["onsinging"].intValue
        heardhalf = jsondata["heardhalf"].stringValue
        ended = jsondata["ended"]
    }
}
