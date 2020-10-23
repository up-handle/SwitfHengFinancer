//
//  ProjectPageShowModel.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/11.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SwiftyJSON

struct  ProjectPageShowModel {
    
    var limit: String?
    var page: String?
    var dict:ProjectDescribePageModel?
    var list:[ProjectEveryValueModel]?
    
    
    init (jsonData:JSON){
        
        limit = jsonData["limit"].stringValue
        page = jsonData["page"].stringValue
        //
        dict = ProjectDescribePageModel(jsonData: jsonData["dict"])
        let listArr:NSMutableArray = NSMutableArray()
        // 在这里需要注意的是：此时的index应该是 0..<json.count的字符串
        for (_, subJSON) : (String, JSON) in jsonData["list"] {
            let model:ProjectEveryValueModel = ProjectEveryValueModel(jsonData: subJSON)
            listArr.add(model)
        }
        list = listArr.copy() as? [ProjectEveryValueModel]
    }
}


struct ProjectEveryValueModel {
    
    var share_logo:String?
    var share_desc:String?
    var join_condition:String?
    var product_id:String?
    var annualized_rate_of_return:String?
    var product_name:String?
    var detail_share_url:String?
    var detail_url:String?
    var lock_period:String?
    
    init(jsonData:JSON) {
        share_logo = jsonData ["share_logo"].stringValue
        share_desc = jsonData ["share_desc"].stringValue
        join_condition = jsonData["join_condition"].stringValue
        annualized_rate_of_return = jsonData["annualized_rate_of_return"].stringValue
        product_name = jsonData["product_name"].stringValue
        detail_share_url = jsonData["detail_share_url"].stringValue
        detail_url = jsonData["detail_url"].stringValue
        lock_period = jsonData["lock_period"].stringValue
    }
}



struct ProjectDescribePageModel {
    
    var detail_share_url_desc:String?
    var header_desc:String?
    var annualized_rate_of_return_unit:String?
    var product_name_desc:String?
    var lock_period_unit:String?
    var join_condition_unit:String?
    var join_condition_desc:String?
    var share_desc_desc:String?
    var share_logo_desc:String?
    var lock_period_desc:String?
    var annualized_rate_of_return_desc:String?
    var product_id_desc:String?
    var detail_url_desc:String?
    
    init(jsonData:JSON) {
        detail_share_url_desc = jsonData["detail_share_url_desc"].stringValue
        header_desc = jsonData["header_desc"].stringValue
        annualized_rate_of_return_unit = jsonData["annualized_rate_of_return_unit"].stringValue
        product_name_desc = jsonData["product_name_desc"].stringValue
        lock_period_unit = jsonData["lock_period_unit"].stringValue
        join_condition_unit = jsonData["join_condition_unit"].stringValue
        join_condition_desc = jsonData["join_condition_desc"].stringValue
        share_desc_desc = jsonData["share_desc_desc"].stringValue
        share_logo_desc = jsonData["share_logo_desc"].stringValue
        lock_period_desc = jsonData["lock_period_desc"].stringValue
        annualized_rate_of_return_desc = jsonData["annualized_rate_of_return_desc"].stringValue
        product_id_desc = jsonData["product_id_desc"].stringValue
        detail_url_desc = jsonData["detail_url_desc"].stringValue
    }
  
}

