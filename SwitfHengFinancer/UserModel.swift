//
//  UserModel.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SwiftyJSON

class  UserModel: NSObject {
    
    var username: String?
    
    var realname: String?
    
    var phone: String = ""
    
    var studioStatus: String?
    
    var userId: String?
    
    var timestamp:CLong = 0; // 服务器时间戳

    var token: String {
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue, forKey: "accessToken")
            userDefault.synchronize()
        }
        get {
            let showToke:String = UserDefaults.standard.object(forKey:"accessToken") as? String ?? ""
            return showToke
        }
    }

   convenience init (jsonData: JSON) {
        self.init()
        username      = jsonData["username"].stringValue
        realname      = jsonData["realname"].stringValue
        phone         = jsonData["phone"].stringValue
        token         = jsonData["accessToken"].stringValue
        studioStatus  = jsonData["studioStatus"].stringValue
    }
    
    
}
