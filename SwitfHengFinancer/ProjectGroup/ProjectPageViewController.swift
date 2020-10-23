//
//  ProjectPageViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class ProjectPageViewController: HFBaseViewController {
    
    var tableView:UITableView = UITableView()
    var dataList:NSMutableArray?
    
    var headerShowLab:UILabel? = nil
    
    var indexPage:Int = 1
    
    
    lazy var headerView:UIView = {()->UIView in
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        view.backgroundColor = projectBgColor
        
        let label:UILabel = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#3A3A3A")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //label.text = "推荐标的来自XXX平台"
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(view).offset(10)
            make.leading.equalTo(20)
        }
        self.headerShowLab = label

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "项目"
        setNavLeftItem(title: "", imageStr: "")
        //tableView
        let screenFrame = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenFrame.width, height: 15))
        view.backgroundColor = projectBgColor
        self.tableView.tableFooterView = view
        self.tableView.tableHeaderView = self.headerView

        self.tableView.frame = CGRect(x: 0, y: 0, width: screenFrame.width, height: screenFrame.height - navigationAllHeight - tabBarHeight)
        self.tableView.backgroundColor = projectBgColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        self.tableView .register(ProjectPageTableViewCell.self, forCellReuseIdentifier: "ProjectPageTableViewCellId")
        //
        self.dataList = NSMutableArray()
        //
        self.tableView.mj_header = RefreshView(refreshingBlock: {
            [weak self]() -> Void in
            self?.headerRefresh()
        })
        
        self.tableView.mj_footer = LoadMoreView(refreshingBlock: {
            [weak self]() -> Void in
            self?.footerRefresh()
        })
        
        //加载网络
        projectPageRequestNet()
    }
    
    // 顶部刷新
    @objc func headerRefresh(){
        print("下拉刷新")
        self.dataList?.removeAllObjects()
        self.tableView.mj_footer?.resetNoMoreData()
        self.tableView.mj_header?.endRefreshing()
        indexPage = 1
        projectPageRequestNet()
     }
    
    // 底部刷新
   @objc func footerRefresh(){
       print("上拉刷新")
       indexPage += 1
       projectPageRequestNet()
       self.tableView.mj_footer?.endRefreshing()
    }
    
    var projectPageModel:ProjectPageShowModel?
    
    func projectPageRequestNet(){
        print("点击了button")
        let dict = ["limit":10,"page":indexPage]
        NetWorkTool.makePostRequest(url: hfProductPageApi, parameters: dict, successHandle: { (json) in
            let model = ProjectPageShowModel.init(jsonData: json)
            self.projectPageModel = model
            //
            let dataArr = model.list
            if dataArr?.count == 0 {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                self.dataList?.addObjects(from: dataArr!)
                //
                self.headerShowLab?.text = model.dict?.header_desc
                self.tableView.reloadData()
            }
        }, netWorkFailHandler: {(failHandler) in
        }) {(error) in

        }
    }
}

extension ProjectPageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108.0 + 15.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProjectPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProjectPageTableViewCellId", for: indexPath) as! ProjectPageTableViewCell
        cell.selectionStyle = .none
        
        if let dataArrList = self.dataList {
            let showCellModel:ProjectEveryValueModel = dataArrList[indexPath.row] as! ProjectEveryValueModel
            let pageShowDict:ProjectDescribePageModel = (self.projectPageModel?.dict)!
             cell.passProjectPageShowModelMethod(model: showCellModel,showPageDict:pageShowDict)
        }
        return cell
    }
    
}

