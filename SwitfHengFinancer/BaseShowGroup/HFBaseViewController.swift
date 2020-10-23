//
//  HFBaseViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class HFBaseViewController: UIViewController {
    
    //是否是隐藏导航底部的线条
    var hideNavLine:Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0);
        
        iOS13Adaptation()
        setNavLeftItem(title: "", imageStr: "leftItem")
    }

    func iOS13Adaptation(){
        if #available(iOS 13.0, *) {
            self.modalPresentationStyle = .fullScreen;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.hideNavLine {
            self.navigationController?.navigationBar.shadowImage = HFBaseTools.creatImageWithColor(color: UIColor.hexadecimalColor(hexadecimal: "#EAECF1"))
        }else{
            self.navigationController?.navigationBar.shadowImage = HFBaseTools.creatImageWithColor(color: UIColor.white)
        }
    }
}

/////
extension HFBaseViewController{
    
    //MARK:设置leftItem显示
    func setNavLeftItem(title:String,imageStr:String){
        var image:UIImage? = nil
        if  imageStr.count > 0 {
            image = UIImage.init(named: imageStr)
        }
        let leftButton = UIButton(type: .custom)
        leftButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftButton.setTitle(title, for: .normal)
        leftButton.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#999999"), for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        leftButton.setImage(image, for: .normal)
        leftButton.setImage(image, for: .selected)
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.contentHorizontalAlignment = .left
        leftButton.addTarget(self, action: #selector(pageNavLeftItemGoBackMethod), for: .touchUpInside)
        let leftItem :UIBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftItem
    }
       
       
   @objc func pageNavLeftItemGoBackMethod(){
       if self.presentingViewController != nil && self.navigationController?.viewControllers.count == 1 {
           self.dismiss(animated: true, completion: nil)
       }else{
           self.navigationController?.popViewController(animated: true)
       }
   }
    //
}
