//
//  SliderCustomerHeaderView.swift
//  SwitfHengFinancer
//
//  Created by MacPro on 2020/5/16.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
//MARK:上部分滑块模块
class SliderCustomerHeaderView: UIView {

     var passSliderTypeBlock:((String) ->())!
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        var _leftTipLab:UILabel?
        var _rightTipLab:UILabel?
        var _lineView:UIView?
        var _isSelectLeftBool:Bool = true
        
        func createShowSliderSelectUI(){
            let leftView:UIView = UIView()
            self.addSubview(leftView)
            leftView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(self)
                make.leading.equalTo(15)
                make.width.equalTo(ScreenWidth/2-30)
            }
            let leftTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickSliderLeftViewTap))
            leftView.addGestureRecognizer(leftTap)
            
            let leftTipLab:UILabel = UILabel()
            leftTipLab.text = "已交易(2人)"
            leftTipLab.font = UIFont.boldSystemFont(ofSize: 15)
            leftView.addSubview(leftTipLab)
            leftTipLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(leftView)
                make.centerY.equalTo(leftView)
            }
            _leftTipLab = leftTipLab
            _isSelectLeftBool = true
            
            //
            let rightView:UIView = UIView()
            self.addSubview(rightView)
            rightView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(self)
                make.trailing.equalTo(self).offset(-15)
                make.leading.equalTo(leftView.snp.trailing).offset(30)
            }
            let rightTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickSliderRightViewTap))
            rightView.addGestureRecognizer(rightTap)
            
            let rightTipLab:UILabel = UILabel()
            rightTipLab.text = "未交易(3人)"
            rightTipLab.font = UIFont.boldSystemFont(ofSize: 15)
            rightView.addSubview(rightTipLab)
            rightTipLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(rightView)
                make.centerY.equalTo(rightView)
            }
            _rightTipLab = rightTipLab
            //
            _lineView = UIView()
            _lineView?.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#597DFF")
            self.addSubview(_lineView!)

            if MyCustomerSelectShowType.selectSliderType == "1" {
              _leftTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#597DFF")
              _rightTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#3A3A3A")
              _lineView?.snp.makeConstraints({ (make) in
                  make.bottom.equalTo(self)
                  make.height.equalTo(2)
                  make.leading.equalTo(_leftTipLab!.snp.leading)
                  make.trailing.equalTo(_leftTipLab!.snp.trailing)
              })
            }else{
                 _leftTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#3A3A3A")
                  _rightTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#597DFF")
                  _lineView?.snp.makeConstraints({ (make) in
                      make.bottom.equalTo(self)
                      make.height.equalTo(2)
                      make.leading.equalTo(_rightTipLab!.snp.leading)
                      make.trailing.equalTo(_rightTipLab!.snp.trailing)
                  })
            }
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            //
            createShowSliderSelectUI()
        }
        
        @objc func clickSliderLeftViewTap(){
            
            if !_isSelectLeftBool {
               _isSelectLeftBool = true
               print("点击了左边-已交易")
               passSliderTypeBlock("1")
            }
        }
        
       func clickLeftSliderChangeSliderShowUI(){
            _isSelectLeftBool = true
           _leftTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#597DFF")
           _rightTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#3A3A3A")
           _lineView?.snp.remakeConstraints({ (make) in
               make.bottom.equalTo(self)
               make.height.equalTo(2)
               make.leading.equalTo(_leftTipLab!.snp.leading)
               make.trailing.equalTo(_leftTipLab!.snp.trailing)
           })
           updataPageShowUIMake()
       }
        
       @objc func clickSliderRightViewTap(){

           if _isSelectLeftBool {
                _isSelectLeftBool = false
                print("点击了右边-未交易")
                //
                passSliderTypeBlock("2")
            }
        }
    
      func clickRightSliderChangeSliderShowUI(){
         _isSelectLeftBool = false
         _leftTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#3A3A3A")
         _rightTipLab?.textColor = UIColor.hexadecimalColor(hexadecimal:"#597DFF")
         _lineView?.snp.remakeConstraints({ (make) in
            make.bottom.equalTo(self)
            make.height.equalTo(2)
            make.leading.equalTo(_rightTipLab!.snp.leading)
            make.trailing.equalTo(_rightTipLab!.snp.trailing)
         })
         updataPageShowUIMake()
      }
    
        func updataPageShowUIMake(){
            // 告诉self.view约束需要更新
            self.needsUpdateConstraints()
            // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
            self.updateConstraintsIfNeeded()
            UIView.animate(withDuration: TimeInterval(0.15)) {
                self.layoutIfNeeded()
            }
        }

}
