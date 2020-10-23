//
//  AppDelegate.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/6.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //获取屏幕大小
        let screenBounds:CGRect = UIScreen.main.bounds
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width:screenBounds.width, height: screenBounds.height))
        self.window?.backgroundColor = UIColor.white
       
        //选择跟控制器
        HFAppManager.sharedInstance.chooseRootVC(window: window!)
        // 初始化第三方应用
        HFAppManager.sharedInstance.initAppWithApplication(application: application, launchOptions: launchOptions)
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

