//
//  MyCustomerDetailViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/21.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MyCustomerDetailViewController: HFBaseViewController {

    
    var client_id :String? //客户类型
    var clientSlider_typeId:String? //已交易和未交易的区分
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.title = "客户详情"
        
        log("客户详情-client_id--\(String(describing: client_id))");
        
        
        
        
    }
    



}
