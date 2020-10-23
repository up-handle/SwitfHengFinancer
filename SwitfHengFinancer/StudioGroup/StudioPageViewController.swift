//
//  StudioPageViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class StudioPageViewController: HFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "工作室"
        self.view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F3F5F8")
        
        setNavLeftItem(title: "", imageStr: "")
        createStudioPageViewCUI()
        
    }
    
    //MARK:创建UI显示
    func createStudioPageViewCUI(){
        
        let backView:UIView = UIView()
        backView.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(15)
            make.leading.equalTo(self.view).offset(20)
            make.trailing.equalTo(self.view).offset(-20)
            make.height.equalTo(144)
        }
        //
        let titleLab :UILabel = UILabel()
        titleLab.text = "工作台"
        titleLab.textColor = UIColor.hexadecimalColor(hexadecimal: "#3A3A3A")
        titleLab.font = UIFont.boldSystemFont(ofSize: 17)
        backView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(backView).offset(22)
            make.leading.equalTo(backView).offset(20)
        }
        //
        let buttonView:UIView = UIView()
        buttonView.backgroundColor = UIColor.white
        backView.addSubview(buttonView)
        buttonView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.leading.equalTo(backView).offset(5)
            make.bottom.equalTo(backView).offset(-5)
            make.width.equalTo((ScreenWidth-40)/3-20)
        }
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ClickMyCustormViewtojumpMethod))
        buttonView.addGestureRecognizer(tap)
        
        //
        let myCustormImg:UIImageView = UIImageView.init(image: UIImage.init(named: "studio_myCustomer"))
        buttonView.addSubview(myCustormImg)
        myCustormImg.snp.makeConstraints { (make) in
            make.top.equalTo(buttonView).offset(20)
            make.centerX.equalTo(buttonView)
        }
        
        let myCustormLab = UILabel.init()
        myCustormLab.text = "我的客户"
        myCustormLab.textColor = UIColor.hexadecimalColor(hexadecimal: "#3A3A3A")
        myCustormLab.font = UIFont.systemFont(ofSize: 12)
        buttonView.addSubview(myCustormLab)
        myCustormLab.snp.makeConstraints { (make) in
            make.top.equalTo(myCustormImg.snp.bottom).offset(3)
            make.centerX.equalTo(buttonView)
        }
        
        
        
        
    }
    
    //
    @objc func ClickMyCustormViewtojumpMethod(){
      
        let myCustomer = MyCustomerPageViewController()
        self.navigationController?.pushViewController(myCustomer, animated: true)
        
     }
            
    

}
