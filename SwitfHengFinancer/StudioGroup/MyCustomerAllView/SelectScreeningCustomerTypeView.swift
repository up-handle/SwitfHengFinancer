//
//  SelectScreeningCustomerTypeView.swift
//  SwitfHengFinancer
//
//  Created by MacPro on 2020/5/16.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

//MARK:类型选择模块
class SelectScreeningCustomerTypeView: UIView {

      enum SortingType {
            case HoldShunAndPourNoSelect
            case HoldOnlyShunSeclect
            case HoldOnlyPourSelect
            //
            case allShunAndPourNoSelect
            case allOnlyShunSelect
            case allOnlyPortSelect
        }
        //
        var passSelectScreeningHoldMoneyType:((String)->Void)!
        //
        var passSelectScreeningAllMoneyType:((String)->Void)!
    //
    //    var isHoldMoneySelect_Shun:Bool = true
    //
    //    var isAllMoneySelect_shun:Bool = true
        
        
        var _holdShunImg:UIImageView?
        var _holdPourImg:UIImageView?
        
        var _allShunImg:UIImageView?
        var _allPourImg:UIImageView?
        
        override init(frame: CGRect) {
            super.init(frame: frame)

            createShowSelectHeaderType()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func createShowSelectHeaderType(){
            
            let nameView:UIView = UIView()
            self.addSubview(nameView)
            nameView.snp.makeConstraints { (make) in
                make.leading.top.bottom.equalTo(self)
                make.width.equalTo(ScreenWidth * 0.18)
            }
            let nameLab:UILabel = UILabel()
            nameLab.text = "姓名"
            nameLab.textColor = UIColor.hexadecimalColor(hexadecimal: "#9395A0")
            nameLab.font = UIFont.systemFont(ofSize: 12)
            nameView.addSubview(nameLab)
            nameLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameView)
                make.centerY.equalTo(nameView)
            }
            //
            let holdMoneyView:UIView = UIView()
            self.addSubview(holdMoneyView)
            holdMoneyView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(self)
                make.leading.equalTo(nameView.snp.trailing)
                make.width.equalTo(ScreenWidth * 0.41)
            }
            
            let holdMoneyLab:UILabel = UILabel()
            holdMoneyLab.text = "持有中金额(元)"
            holdMoneyLab.font = UIFont.systemFont(ofSize: 12)
            holdMoneyLab.textColor = UIColor.hexadecimalColor(hexadecimal: "#9395A0")
            holdMoneyView.addSubview(holdMoneyLab)
            holdMoneyLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(holdMoneyView).offset(-8)
                make.centerY.equalTo(holdMoneyView)
            }
            holdMoneyLab.isUserInteractionEnabled = true
            let holdMoneyTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(holdMoneyClickSortingMethod))
            holdMoneyLab.addGestureRecognizer(holdMoneyTap)
            
            //
            let holdShunImg:UIImageView = UIImageView(image: UIImage(named: "asc_normal"))
            holdMoneyView.addSubview(holdShunImg)
            holdShunImg.snp.makeConstraints { (make) in
                make.top.equalTo(holdMoneyLab).offset(2)
                make.leading.equalTo(holdMoneyLab.snp.trailing).offset(5)
            }
            _holdShunImg = holdShunImg
            
            let holdPourImg:UIImageView = UIImageView(image: UIImage(named: "desc_normal"))
            holdMoneyView.addSubview(holdPourImg)
            holdPourImg.snp.makeConstraints { (make) in
                make.top.equalTo(holdShunImg.snp.bottom).offset(3)
                make.leading.equalTo(holdMoneyLab.snp.trailing).offset(5)
            }
            _holdPourImg = holdPourImg
            //
            let allMoneyView:UIView = UIView()
            self.addSubview(allMoneyView)
            allMoneyView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(self)
                make.leading.equalTo(holdMoneyView.snp.trailing)
                make.width.equalTo(ScreenWidth * 0.41)
            }
            
            let allMoneyLab:UILabel = UILabel()
            allMoneyLab.text = "累计交易金额(元)"
            allMoneyLab.font = UIFont.systemFont(ofSize: 12)
            allMoneyLab.textColor = UIColor.hexadecimalColor(hexadecimal: "#9395A0")
            allMoneyView.addSubview(allMoneyLab)
            allMoneyLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(allMoneyView).offset(-8)
                make.centerY.equalTo(allMoneyView)
            }
            
            allMoneyLab.isUserInteractionEnabled = true
            let allMoneyTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(allMoneyClickSortingMethod))
            allMoneyLab.addGestureRecognizer(allMoneyTap)
            
            //
            let allShunImg:UIImageView = UIImageView(image: UIImage(named: "asc_normal"))
            allMoneyView.addSubview(allShunImg)
            allShunImg.snp.makeConstraints { (make) in
                make.top.equalTo(allMoneyLab).offset(2)
                make.leading.equalTo(allMoneyLab.snp.trailing).offset(5)
            }
            _allShunImg = allShunImg
            
            let allPourImg:UIImageView = UIImageView(image: UIImage(named: "desc_normal"))
            holdMoneyView.addSubview(allPourImg)
            allPourImg.snp.makeConstraints { (make) in
                make.top.equalTo(allShunImg.snp.bottom).offset(3)
                make.leading.equalTo(allMoneyLab.snp.trailing).offset(5)
            }
            _allPourImg = allPourImg
     
        }
        
        func jumpToShowSortingTypeImage(showType:SortingType){
            switch showType {
                case .HoldShunAndPourNoSelect:
                    _holdShunImg?.image = UIImage(named: "asc_normal")
                    _holdPourImg?.image =  UIImage(named: "desc_normal")
                case .HoldOnlyShunSeclect:
                    _holdShunImg?.image = UIImage(named: "asc_selected")
                    _holdPourImg?.image =  UIImage(named: "desc_normal")
                case .HoldOnlyPourSelect:
                    _holdShunImg?.image = UIImage(named: "asc_normal")
                    _holdPourImg?.image =  UIImage(named: "desc_selected")
                //
                case .allShunAndPourNoSelect:
                    _allShunImg?.image = UIImage(named: "asc_normal")
                    _allPourImg?.image =  UIImage(named: "desc_normal")
                    
                case .allOnlyShunSelect:
                    _allShunImg?.image = UIImage(named: "asc_selected")
                    _allPourImg?.image =  UIImage(named: "desc_normal")
                    
                case .allOnlyPortSelect:
                   _allShunImg?.image = UIImage(named: "asc_normal")
                   _allPourImg?.image =  UIImage(named: "desc_selected")
            }
        }
        
        //持有中金额点击排序
        @objc func holdMoneyClickSortingMethod(){
            print("持有中金额点击排序")
            if MyCustomerSelectShowType.selectSliderType == "1" {
                
                //如果累计已经排序但是现在点击持有中排序
                if MyCustomerSelectShowType.selectSlideLefttAndAllValue == "1" {
                    MyCustomerSelectShowType.SelectLeftFirstHoldLastAll = "2"
                }
                //
                if (MyCustomerSelectShowType.selectSlideLeftAndHoldValue != "1") { //正序
                    jumpToShowSortingTypeImage(showType:.HoldOnlyShunSeclect)
                    passSelectScreeningHoldMoneyType("1")
                }else{  //倒序
                    jumpToShowSortingTypeImage(showType:.HoldOnlyPourSelect)
                    passSelectScreeningHoldMoneyType("2")
                }
            }else{
                
                //如果累计已经排序但是现在点击持有中排序
                if MyCustomerSelectShowType.selectSlideRightAndAllValue == "1" {
                    MyCustomerSelectShowType.SelectRightFirstHoldLastAll = "2"
                }
                //
                if (MyCustomerSelectShowType.selectSlideRightAndHoldValue != "1") { //正序
                    jumpToShowSortingTypeImage(showType:.HoldOnlyShunSeclect)
                    passSelectScreeningHoldMoneyType("1")
                }else{  //倒序
                    jumpToShowSortingTypeImage(showType:.HoldOnlyPourSelect)
                    passSelectScreeningHoldMoneyType("2")
                }
            }
        }
        
        //累计交易金额点击排序
        @objc func allMoneyClickSortingMethod(){
            print("累计交易金额点击排序")
            if MyCustomerSelectShowType.selectSliderType == "1" {
                
                //如果持有中已经排序但是现在点击累计排序
                if MyCustomerSelectShowType.selectSlideLeftAndHoldValue == "1" {
                    MyCustomerSelectShowType.SelectLeftFirstHoldLastAll = "1"
                }
                
                
                if (MyCustomerSelectShowType.selectSlideLefttAndAllValue != "1") { //正序
                    jumpToShowSortingTypeImage(showType:.allOnlyShunSelect)
                    passSelectScreeningAllMoneyType("1")
                }else{ //倒序
                    jumpToShowSortingTypeImage(showType:.allOnlyPortSelect)
                    passSelectScreeningAllMoneyType("2")
                }
            }else{
                
                //如果持有中已经排序但是现在点击累计排序
                if MyCustomerSelectShowType.selectSlideLefttAndAllValue == "1" {
                    MyCustomerSelectShowType.SelectRightFirstHoldLastAll = "1"
                }
                //
                if  (MyCustomerSelectShowType.selectSlideRightAndAllValue != "1") { //正序
                    jumpToShowSortingTypeImage(showType:.allOnlyShunSelect)
                    passSelectScreeningAllMoneyType("1")
                }else{ //倒序
                    jumpToShowSortingTypeImage(showType:.allOnlyPortSelect)
                    passSelectScreeningAllMoneyType("2")
                }
            }
        }

        
        func RefreshShowScreeningShowType(){
            
            let sliderType = MyCustomerSelectShowType.selectSliderType
            
            if sliderType == "1" {
                let holdSortTypeStr = MyCustomerSelectShowType.selectSlideLeftAndHoldValue
                if holdSortTypeStr == "0" {
                    jumpToShowSortingTypeImage(showType:.HoldShunAndPourNoSelect)
                }else if(holdSortTypeStr == "1"){
                    jumpToShowSortingTypeImage(showType:.HoldOnlyShunSeclect)
                }else{
                    jumpToShowSortingTypeImage(showType:.HoldOnlyPourSelect)
                }
                
                let allTypeStr = MyCustomerSelectShowType.selectSlideLefttAndAllValue
                if allTypeStr == "0" {
                    jumpToShowSortingTypeImage(showType: .allShunAndPourNoSelect)
                }else if(allTypeStr == "1"){
                     jumpToShowSortingTypeImage(showType: .allOnlyShunSelect)
                }else{
                    jumpToShowSortingTypeImage(showType: .allOnlyPortSelect)
                }
            }else{
            
                let holdSortTypeStr = MyCustomerSelectShowType.selectSlideRightAndHoldValue
                if holdSortTypeStr == "0" {
                    jumpToShowSortingTypeImage(showType:.HoldShunAndPourNoSelect)
                }else if(holdSortTypeStr == "1"){
                    jumpToShowSortingTypeImage(showType:.HoldOnlyShunSeclect)
                }else{
                    jumpToShowSortingTypeImage(showType:.HoldOnlyPourSelect)
                }
               
                let allTypeStr = MyCustomerSelectShowType.selectSlideRightAndAllValue
                if allTypeStr == "0" {
                    jumpToShowSortingTypeImage(showType: .allShunAndPourNoSelect)
                }else if(allTypeStr == "1"){
                     jumpToShowSortingTypeImage(showType: .allOnlyShunSelect)
                }else{
                    jumpToShowSortingTypeImage(showType: .allOnlyPortSelect)
                }

            }
        }
    
}
