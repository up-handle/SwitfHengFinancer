//
//  MyCustomerPageHeadView.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/15.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

 struct MyCustomerSelectShowType {
    
   static var selectSliderType:String  = "1"
   //
   static var selectSlideLeftAndHoldValue:String = "0"
   static var selectSlideLefttAndAllValue:String  = "0"
   //0：不先后排序    1:是先排序持有中后累计排序   2：先累计排序后持有中排序
   static var SelectLeftFirstHoldLastAll:String = "0"
   //
   static var selectSlideRightAndHoldValue:String = "0"
   static var selectSlideRightAndAllValue:String  = "0"
   //0：不先后排序    1:是先排序持有中后累计排序   2：先累计排序后持有中排序
   static var SelectRightFirstHoldLastAll:String = "0"
    
    static func selectRestoreInitialState(){
        self.selectSliderType = "1"
        self.selectSlideLeftAndHoldValue = "0"
        self.selectSlideRightAndAllValue = "0"
        self.selectSlideRightAndHoldValue = "0"
        self.selectSlideRightAndAllValue = "0"
        //
        SelectLeftFirstHoldLastAll = "0"
        SelectRightFirstHoldLastAll = "0"
    }
}

//
protocol ChangeCustomerScrollerSlider {

    //改变scroller的滑动
    func changeScrollerAfterClickSlider(typeShow:String)
    func passTriggeredMyCustomerHeaderClickMethodToVC()
}

class MyCustomerPageHeadView: UIView {
    
    //
    var delegate:ChangeCustomerScrollerSlider!
    
    lazy var sliderHeaderView:SliderCustomerHeaderView = {() -> SliderCustomerHeaderView in
        let sliderHeaderView = SliderCustomerHeaderView()
        sliderHeaderView.backgroundColor = UIColor.white
        //
        sliderHeaderView.passSliderTypeBlock = {
            (text:String) in
//            print("选择类型--->","\(text)")
            //
            self.changeSliderTypeShowMethod(sliderType:text)
            //
            //点击slider之后改变，改变scroller的滑动
            self.delegate.changeScrollerAfterClickSlider(typeShow: text)
            
        }
        return sliderHeaderView;
    }()
    
    //滑动ScrollerView之后-改变slider的状态值
    func changeSliderTypeShowMethod(sliderType:String){
        
        if MyCustomerSelectShowType.selectSliderType == sliderType {
            print("相同操作，跳过")
            return
        }
        //1--是已经交易  2--未交易
        MyCustomerSelectShowType.selectSliderType  = sliderType
        
        if sliderType == "1" {
            sliderHeaderView.clickLeftSliderChangeSliderShowUI()
        }else if sliderType == "2" {
            sliderHeaderView.clickRightSliderChangeSliderShowUI()
        }
        //
        selectScreeningView.RefreshShowScreeningShowType()
    }
    
    lazy var selectScreeningView:SelectScreeningCustomerTypeView = { ()->SelectScreeningCustomerTypeView in
        
        let selectScreeningView  = SelectScreeningCustomerTypeView()
        selectScreeningView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EFF0F3")
        selectScreeningView.passSelectScreeningHoldMoneyType = {(holdMoneyTypeStr:String) in
//            log(holdMoneyTypeStr)
            //持有中的筛选
            if (MyCustomerSelectShowType.selectSliderType == "1"){
                MyCustomerSelectShowType.selectSlideLeftAndHoldValue = holdMoneyTypeStr
            }else{
                MyCustomerSelectShowType.selectSlideRightAndHoldValue = holdMoneyTypeStr
            }
            self.triggeredMyCustomerHeaderClickMethod()
        }
        selectScreeningView.passSelectScreeningAllMoneyType = {(allMoneyType:String) in
            log(allMoneyType)
            //累积中的筛选
            if (MyCustomerSelectShowType.selectSliderType == "1"){
                MyCustomerSelectShowType.selectSlideLefttAndAllValue = allMoneyType
            }else{
                MyCustomerSelectShowType.selectSlideRightAndAllValue = allMoneyType
            }
         
            self.triggeredMyCustomerHeaderClickMethod()
        }
        return selectScreeningView
    }()
    
    
    
    //点击不同排序之后给VC页面发送代理-然后让不同的VC请求接口刷新
    func triggeredMyCustomerHeaderClickMethod(){
        self.delegate.passTriggeredMyCustomerHeaderClickMethodToVC()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createPageHeaderShowViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createPageHeaderShowViewUI(){
        
        self.addSubview(self.sliderHeaderView)
        self.sliderHeaderView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(44)
        }
        self.addSubview(self.selectScreeningView)
        self.selectScreeningView.snp.makeConstraints { (make) in
            make.top.equalTo(self.sliderHeaderView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
    }
    

}
