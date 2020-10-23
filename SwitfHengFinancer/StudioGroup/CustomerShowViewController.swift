//
//  CustomerShowViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/15.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import MJRefresh

class CustomerShowViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView = UITableView()
    
    var dataList:NSMutableArray?
    
    var page:NSInteger = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: ScreenHeight - navigationAllHeight - 76 - bottomSafeAreaHeight)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView .register(MyCustomerTableViewCell.self, forCellReuseIdentifier: "MyCustomerTableViewCellID")
        self.view.addSubview(self.tableView)
        //
        self.dataList = NSMutableArray()
    }
    
    //是本页面的刷新请求还是 从外部点击的改变类型的请求
    //ture:外部刷新来的请求  false是从本页面的上拉下拉的请求
    func requestShowMyCustomerNetDataForToShow(_ isExternalEnter:Bool){
        
        if isExternalEnter {
            self.dataList?.removeAllObjects()
        }
        
        var all_amount_order:String = ""
        var invest_amount_order:String = ""
        var sort_order:String = ""

        let whether_to_lend:String = MyCustomerSelectShowType.selectSliderType
        
        if whether_to_lend == "1" {
            all_amount_order = MyCustomerSelectShowType.selectSlideLefttAndAllValue
            invest_amount_order = MyCustomerSelectShowType.selectSlideLeftAndHoldValue
            
            sort_order = MyCustomerSelectShowType.SelectLeftFirstHoldLastAll;
            
        }else if whether_to_lend == "2"{
            all_amount_order = MyCustomerSelectShowType.selectSlideRightAndAllValue
            invest_amount_order = MyCustomerSelectShowType.selectSlideRightAndHoldValue
             sort_order = MyCustomerSelectShowType.SelectRightFirstHoldLastAll;
        }
    
        log("我的客户列表请求--whether_to_lend:\(whether_to_lend)---invest_amount_order:\(invest_amount_order)----all_amount_order:\(all_amount_order)-----sort_order:\(sort_order)")
        
        let dict:[String:Any] = [
            "whether_to_lend":whether_to_lend,
            "all_amount_order":all_amount_order == "0" ?"":all_amount_order,
            "invest_amount_order":invest_amount_order == "0" ?"":invest_amount_order,
            "sort_order":sort_order == "0" ?"":sort_order,
            "limit":"20",
            "page":page,
        ]
        
        NetWorkTool.makePostRequest(url: hfMyCustomerPageListAPi, parameters: dict, successHandle: { (json) in
            let model = MyCustomerPageShowModel.init(jsonData: json)
            
            self.dataList?.addObjects(from: model.list!)
            
            self.tableView.reloadData()
        }, netWorkFailHandler: { (fail) in
            log(fail)
        }) { (error) in
            log(error)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyCustomerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCustomerTableViewCellID", for: indexPath) as! MyCustomerTableViewCell
        cell.passMyCustomerTableCellNetDataShowMethod(model: dataList?[indexPath.row] as! EveryCustomerListModel)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if MyCustomerSelectShowType.selectSliderType == "1" {
            
            let everyModel:EveryCustomerListModel = self.dataList?[indexPath.row] as! EveryCustomerListModel
            
            let client_idStr:String = everyModel.client_id ?? ""
            let sliderSelectType:String = MyCustomerSelectShowType.selectSliderType;
            
           let detailVC = MyCustomerDetailViewController()
            detailVC.client_id = client_idStr
            detailVC.clientSlider_typeId = sliderSelectType
           self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
}
