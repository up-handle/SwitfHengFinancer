//
//  HFAppManager.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/6.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class HFAppManager: NSObject {


    fileprivate var _window:UIWindow?
    
    static let sharedInstance = HFAppManager()
    
    private override init() {
        
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginSuccessNotiCation), name:NSNotification.Name(rawValue: "LoginSuccessNoti"), object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OutLoginNotiCation), name: NSNotification.Name(rawValue: "OutLoginNotiCationValue"), object: nil)
         iOS11Adaptation()
        
    }

    func iOS11Adaptation(){
           if #available(iOS 11.0, *) {
               UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
               UITableView.appearance().estimatedSectionHeaderHeight = 0
               UITableView.appearance().estimatedSectionFooterHeight = 0
           }
       }
    
    func chooseRootVC(window:UIWindow) {
        _window = window;
        let model:UserModel = UserModel()
        let tokenStr:String = model.token
        if tokenStr != "" {
             jumpToMainVC(window: window)
        }else{
             jumpToLoginVC(window: window)
        }
    }
    // APP初始第三方库
    func initAppWithApplication(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    }
       
    // 跳转到主页
    func jumpToMainVC(window: UIWindow) {
        let tabBarVC:HFTabBarViewController = HFTabBarViewController()
        tabBarVC.selectedIndex = 1
        window.rootViewController = tabBarVC
    }
       
   // 跳转到登录
   func jumpToLoginVC(window: UIWindow) {
       //设置
       let loginVC:LoginShowViewController = LoginShowViewController()
       window.rootViewController = loginVC
   }
    
    //登录成功通知
    @objc func LoginSuccessNotiCation(){
        jumpToMainVC(window: _window!)
    }
    //退出登录的通知
    @objc func OutLoginNotiCation(){
        
        let userModel:UserModel = UserModel.init(jsonData: [:])
        print(userModel)
        jumpToLoginVC(window: _window!)
    }
}
