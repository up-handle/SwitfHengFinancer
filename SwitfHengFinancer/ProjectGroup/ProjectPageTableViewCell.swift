//
//  ProjectPageTableViewCell.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/12.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SnapKit

class ProjectPageTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = projectBgColor
        addPageUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:需要赋值操作
    func passProjectPageShowModelMethod(model:ProjectEveryValueModel,showPageDict:ProjectDescribePageModel) {
    
        let cellModel:ProjectEveryValueModel = model
        self.labTap.text = cellModel.product_name
        //
        passNeedBeautifyNeedLabel(passShowLabel: self.rateShowLab, beforeStr: cellModel.annualized_rate_of_return!, afterStr: showPageDict.annualized_rate_of_return_unit!, afterStrFontInt: 17.0)
        self.rateTipLab.text = showPageDict.annualized_rate_of_return_desc
        
        passNeedBeautifyNeedLabel(passShowLabel: self.monthShowLab, beforeStr: cellModel.lock_period!, afterStr: showPageDict.lock_period_unit!, afterStrFontInt: 12.0)
        self.monthTipLab.text = showPageDict.lock_period_desc
        
        //
        passNeedBeautifyNeedLabel(passShowLabel: self.conditionShowLab, beforeStr: cellModel.join_condition!, afterStr: showPageDict.join_condition_unit!, afterStrFontInt: 12.0)
        self.conditionTipLab.text = showPageDict.join_condition_desc
        
    }
    //MARK:NSMutableAttributedString
    func passNeedBeautifyNeedLabel(passShowLabel:UILabel,beforeStr:String,afterStr:String,afterStrFontInt:CGFloat){
        
        let string:String = beforeStr + afterStr
        let contentStr:NSMutableAttributedString = NSMutableAttributedString.init(string: string)
        let redRange:NSRange  = NSRange.init(location: beforeStr.count, length: afterStr.count)
        contentStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: afterStrFontInt), range: redRange)
        passShowLabel.attributedText = contentStr
    }
    
    //MARK:懒加载
    
    lazy var backView = {()->UIView in
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    lazy var labTap = { () -> UILabel in
        let lable = UILabel.init()
        lable.textColor = UIColor.hexadecimalColor(hexadecimal: "#3A3A3A")
        lable.text = "定利宝DL3"
        lable.font = UIFont.systemFont(ofSize:15)
        return lable
    }()
    
    lazy var shareButton:UIButton = { ()->UIButton in
        let button :UIButton = UIButton(type: .custom)
        button.setBackgroundImage(UIImage.init(named: "toShareImage"), for: .normal)
        button.addTarget(self, action: #selector(projectPageClickShareBtn), for: .touchUpInside)
        return button
    }()
    
    @objc func projectPageClickShareBtn(){
        print("点击分享按钮")
    }
    
    //
    lazy var rateShowLab:UILabel = { ()-> UILabel in
        let label:UILabel = UILabel()
        label.text = "9.80%"
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#597DFF")
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    lazy var rateTipLab:UILabel = { ()-> UILabel in
        let label:UILabel = UILabel()
        label.text = "平均年化收益"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#999999")
        return label
    }()
    //
    lazy var monthShowLab:UILabel = { ()-> UILabel in
        let label:UILabel = UILabel()
        label.text = "12个月"
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#3A3A3A")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    lazy var monthTipLab:UILabel = { ()-> UILabel in
        let label:UILabel = UILabel()
        label.text = "锁定期"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#999999")
        return label
    }()
    //
    lazy var conditionShowLab:UILabel = { ()-> UILabel in
        let label:UILabel = UILabel()
        label.text = "1000元"
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#3A3A3A")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    lazy var conditionTipLab:UILabel = { ()-> UILabel in
        let label:UILabel = UILabel()
        label.text = "最小出借金额"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#999999")
        return label
    }()
    //
    
    lazy var stackView:UIStackView = {() ->UIStackView in
        let leftView:UIView = UIView()
        let middleView:UIView = UIView()
        let rightView:UIView = UIView()
        let stackView = UIStackView(arrangedSubviews: [leftView,middleView,rightView])
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = UIColor.lightGray
        return stackView
    }()
    
}

extension ProjectPageTableViewCell{
    //MARK:布局UI显示
      func addPageUI(){
          self.addSubview(self.backView)
          self.backView.snp.makeConstraints { (make) in
              make.top.equalTo(self).offset(15)
              make.leading.equalTo(self).offset(20)
              make.bottom.equalTo(self).offset(0)
              make.trailing.equalTo(self).offset(-20)
          }
          
          self.backView.addSubview(self.labTap)
          self.labTap.snp.makeConstraints { (make) in
              make.top.leading.equalTo(self.backView).offset(15)
          }
          
          self.backView.addSubview(self.shareButton)
          self.shareButton.snp.makeConstraints { (make) in
              make.centerY.equalTo(self.labTap)
              make.trailing.equalTo(self.backView).offset(-15)
              make.width.equalTo(18)
              make.height.equalTo(18)
          }
          //
          self.backView.addSubview(self.stackView)
          self.stackView.snp.makeConstraints { (make) in
              make.top.equalTo(self.labTap.snp.bottom).offset(5)
              make.leading.equalTo(self.backView).offset(5)
              make.trailing.equalTo(self.backView).offset(-5)
              make.bottom.equalTo(self.backView).offset(-5)
          }
      }
      
      override func layoutSubviews() {
           if (self.stackView.frame.width != 0 ){
               //
               let leftView = self.stackView.arrangedSubviews[0]
               leftView.addSubview(self.rateShowLab)
               self.rateShowLab.snp.makeConstraints { (make) in
                   make.centerX.equalTo(leftView)
                   make.top.equalTo(leftView).offset(8)
               }
               leftView.addSubview(self.rateTipLab)
               self.rateTipLab.snp.makeConstraints { (make) in
                   make.centerX.equalTo(leftView)
                   make.top.equalTo(self.rateShowLab.snp.bottom).offset(3)
               }
               //
               let middleView = self.stackView.arrangedSubviews[1]
               middleView.addSubview(self.monthShowLab)
               middleView.addSubview(self.monthTipLab)
               self.monthShowLab.snp.makeConstraints { (make) in
                   make.bottom.equalTo(rateShowLab)
                   make.centerX.equalTo(middleView)
               }
               self.monthTipLab.snp.makeConstraints { (make) in
                   make.centerX.equalTo(middleView)
                   make.centerY.equalTo(self.rateTipLab.snp.centerY)
               }
               //
               let rightView = self.stackView.arrangedSubviews[2]
               rightView.addSubview(self.conditionShowLab)
               rightView.addSubview(self.conditionTipLab)
               self.conditionShowLab.snp.makeConstraints { (make) in
                   make.centerX.equalTo(rightView)
                   make.bottom.equalTo(self.rateShowLab)
               }
               self.conditionTipLab.snp.makeConstraints { (make) in
                   make.centerX.equalTo(rightView)
                   make.centerY.equalTo(self.rateTipLab.snp.centerY)
               }
               
           }
       }
}
