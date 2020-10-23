//
//  MyCustomerPageViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MyCustomerPageViewController: HFBaseViewController , UIScrollViewDelegate, ChangeCustomerScrollerSlider {


    lazy var headerView:MyCustomerPageHeadView = {()-> MyCustomerPageHeadView in
        let headView = MyCustomerPageHeadView();
        headView.delegate = self
        return headView
    }()
    
    var viewCMutarArr:NSMutableArray = NSMutableArray()
    
    var containSet:NSMutableSet = NSMutableSet()
    
    lazy var scrollerView:UIScrollView = {()->UIScrollView in
        let scrollerView = UIScrollView()
        scrollerView.backgroundColor = UIColor.white
        scrollerView.contentSize = CGSize(width: ScreenWidth * 2, height: 0)
        scrollerView.isPagingEnabled = true
        scrollerView.showsVerticalScrollIndicator = true
        scrollerView.delegate = self

        return scrollerView
    }()
    
    //添加VC到scrollerView
    func createMyShowViewControllView(){
        for i in 0...1 {
            let showVC:CustomerShowViewController = CustomerShowViewController()
            showVC.view.frame = CGRect(x: CGFloat(i) * ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight - navigationAllHeight - 76 - bottomSafeAreaHeight)
            if i == 0 {
                showVC.requestShowMyCustomerNetDataForToShow(false)
            }
            log(showVC)
            self.viewCMutarArr.add(showVC);
            self.addChild(showVC)
            self.scrollerView.addSubview(showVC.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的客户"
        self.view.backgroundColor = UIColor.white
        self.hideNavLine = true
        
        createMyCustomerShowHeaderView()
        createMyShowViewControllView()
        //
        containSet.add(1)
    }
    
    
    func createMyCustomerShowHeaderView(){
        //
        self.view .addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(44.0+32.0)
        }
        //
        self.view.addSubview(self.scrollerView)
        self.scrollerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.headerView.snp.bottom)
            make.bottom.equalTo(self.view).offset(-bottomSafeAreaHeight)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let toItemMun:Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        let sliderType:String = String(toItemMun+1)
        self.headerView.changeSliderTypeShowMethod(sliderType: sliderType)
        //底部ScrollerView滑动的时间--改变请求
        self.headerViewChangeIsOrWhetherRequestNetData(toItemMun+1)
    }
    //
    func changeScrollerAfterClickSlider(typeShow:String){
        
        if typeShow == "1" {
            UIView.animate(withDuration: TimeInterval(0.15)) {
                self.scrollerView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }else if typeShow == "2" {
            UIView.animate(withDuration: TimeInterval(0.15)) {
                self.scrollerView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
            }
        }
        //头部slider点击之后选取不同type--改变请求
        let number = Int(typeShow) ?? 1
        self.headerViewChangeIsOrWhetherRequestNetData(number)
        
    }
    
    
    func headerViewChangeIsOrWhetherRequestNetData(_ sliderType:Int){
        
        if containSet.contains(sliderType) {
        }else{
            containSet.add(sliderType)
            //底部ScrollerView滑动的时间--改变请求
            self.passTriggeredMyCustomerHeaderClickMethodToVC()
        }
    }
    
    //重写返回按钮
    override func pageNavLeftItemGoBackMethod(){
        print("goback------------->")
        MyCustomerSelectShowType.selectRestoreInitialState()
        super.pageNavLeftItemGoBackMethod()
    }
    
    //每次点击都触发-触发头部点击--然后发起请求
    func passTriggeredMyCustomerHeaderClickMethodToVC(){
        
        let sliderTypeNum = Int(MyCustomerSelectShowType.selectSliderType) ?? 1
        let selectNum:Int = sliderTypeNum - 1
        
        let showVC:CustomerShowViewController = self.viewCMutarArr[selectNum] as! CustomerShowViewController
        //请求
        showVC.requestShowMyCustomerNetDataForToShow(true)
    }
    
    deinit {
       print("9999999------------->")
    }

    
}
