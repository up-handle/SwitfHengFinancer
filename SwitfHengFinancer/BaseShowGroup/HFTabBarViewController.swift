//
//  HFTabBarViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class HFTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = UIColor.white
        //
        setUpAllChildViewController()
         
    }

    func setUpAllChildViewController(){
        let projectPage:ProjectPageViewController = ProjectPageViewController()
        setUpOneOfChildViewController(projectPage, "ProjectTab_nomal", "ProjectTab_Select", "项目")
        //
        let studioPage:StudioPageViewController = StudioPageViewController()
        setUpOneOfChildViewController(studioPage, "studioTab_normal", "studioTab_select", "工作室")
        
        let minePage:MinePageViewController = MinePageViewController()
        setUpOneOfChildViewController(minePage, "mineTabBar_nomal", "mineTabBar_Select", "我的")
        
    }
    
    func setUpOneOfChildViewController(_ vc:UIViewController, _ image:String , _ selectedImage:String, _ title:String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        let normalDic:NSMutableDictionary = NSMutableDictionary()
        normalDic[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 11)
        normalDic[NSAttributedString.Key.foregroundColor] = UIColor.hexadecimalColor(hexadecimal: "#666666")
        vc.tabBarItem .setTitleTextAttributes(normalDic as? [NSAttributedString.Key : Any], for: .normal)
        //
        let selectDic:NSMutableDictionary = NSMutableDictionary()
        selectDic[NSAttributedString.Key.foregroundColor] = UIColor.hexadecimalColor(hexadecimal: "#3A3A3A")
        vc.tabBarItem.setTitleTextAttributes(selectDic as? [NSAttributedString.Key:Any], for: .selected)
        //
        vc.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: 4)

        let nav:HFNavigationController = HFNavigationController(rootViewController: vc)
    
        self.addChild(nav)
        
        vc.tabBarItem.tag = self.viewControllers!.count - 1;
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
