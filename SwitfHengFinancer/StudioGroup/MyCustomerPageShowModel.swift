//
//  MyCustomerPageShowModel.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/21.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MyCustomerPageShowModel {
    
    let page:String?
    let total:String?
    let limit:String?
    let dict:MyCustomerPageDesDictModel?
    var list:[EveryCustomerListModel]?
    
    init(jsonData:JSON) {
        page = jsonData["page"].stringValue
        total = jsonData["total"].stringValue
        limit = jsonData["limit"].stringValue
        //
        dict = MyCustomerPageDesDictModel(jsonData:jsonData["dict"])
        let listArr:NSMutableArray = NSMutableArray()
        for (_, subJSON):(String,JSON) in jsonData["list"] {
            let model:EveryCustomerListModel = EveryCustomerListModel(jsonData:subJSON)
            listArr.add(model)
        }
        list =  listArr.copy() as? [EveryCustomerListModel]
    }
}

struct EveryCustomerListModel{
    
    let client_status:String?
    let invest_amount_format:String?
    let all_amount:String?
    let client_name:String?
    let all_amount_format:String?
    let invest_amount:String?
    let client_status_key:String?
    
    let client_id:String?
    let client_phone:String?
    let client_phone_format:String?
    
    init(jsonData:JSON) {
        
        client_status = jsonData["client_status"].stringValue
        invest_amount = jsonData["invest_amount"].stringValue
        invest_amount_format = jsonData["invest_amount_format"].stringValue
        all_amount = jsonData["all_amount"].stringValue
        client_name = jsonData["client_name"].stringValue
        all_amount_format = jsonData["all_amount_format"].stringValue
        client_status_key = jsonData["client_status_key"].stringValue
        client_id = jsonData["client_id"].stringValue
        client_phone = jsonData["client_phone"].stringValue
        client_phone_format = jsonData["client_phone_format"].stringValue
        
    }
}

struct MyCustomerPageDesDictModel{
    
    let invest_amount:ShowUnitAndNameModel
    let client_phone:ShowUnitAndNameModel
    let client_status_key:ShowUnitAndNameModel
    let all_amount:ShowUnitAndNameModel
    let client_id:ShowUnitAndNameModel
    let client_name:ShowUnitAndNameModel
    //
    let client_status:ShowUnitAndNameModel
    let all_amount_format:ShowUnitAndNameModel
    let client_phone_format:ShowUnitAndNameModel
    let invest_amount_format:ShowUnitAndNameModel
    
    init(jsonData:JSON) {
        invest_amount = ShowUnitAndNameModel(jsonData:jsonData["invest_amount"])
        client_phone = ShowUnitAndNameModel(jsonData:jsonData["client_phone"])
        client_status_key = ShowUnitAndNameModel(jsonData:jsonData["client_status_key"])
        all_amount = ShowUnitAndNameModel(jsonData:jsonData["all_amount"])
        client_id = ShowUnitAndNameModel(jsonData:jsonData["client_id"])
        client_name = ShowUnitAndNameModel(jsonData:jsonData["client_name"])
        client_status = ShowUnitAndNameModel(jsonData:jsonData["client_status"])
        all_amount_format = ShowUnitAndNameModel(jsonData:jsonData["all_amount_format"])
        client_phone_format = ShowUnitAndNameModel(jsonData:jsonData["client_phone_format"])
        invest_amount_format = ShowUnitAndNameModel(jsonData:jsonData["invest_amount_format"])
    }
}

struct ShowUnitAndNameModel{
    let unit:String?
    let name:String?
    init(jsonData:JSON) {
        unit = jsonData["unit"].stringValue
        name = jsonData["name"].stringValue
    }
}
