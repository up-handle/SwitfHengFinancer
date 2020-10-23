//
//  HFNavigationController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class HFNavigationController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.delegate = self
        
        //设置Navgation的背景颜色
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.hexadecimalColor(hexadecimal:"#3A3A3A") , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
        self.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        
       iOS13NavAdaptation()
        
    }
    
    func iOS13NavAdaptation(){
        if #available(iOS 13.0, *) {
            self.modalPresentationStyle = .fullScreen;
        }
      }
    
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }else{
            viewController.hidesBottomBarWhenPushed = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
