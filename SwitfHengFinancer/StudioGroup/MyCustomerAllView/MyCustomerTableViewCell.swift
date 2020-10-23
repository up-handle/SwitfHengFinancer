//
//  MyCustomerTableViewCell.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/19.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MyCustomerTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(self.nameLab)
        self.contentView.addSubview(self.middleLab)
        self.contentView.addSubview(self.afterLab)
        self.nameLab.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self.contentView)
            make.width.equalTo(ScreenWidth*0.18)
        }
        self.middleLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.leading.equalTo(self.nameLab.snp.trailing)
            make.width.equalTo(ScreenWidth*0.41)
        }
        self.afterLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.leading.equalTo(self.middleLab.snp.trailing)
            make.width.equalTo(ScreenWidth*0.41)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func passMyCustomerTableCellNetDataShowMethod(model:EveryCustomerListModel){
        
        self.nameLab.text = model.client_name
        self.middleLab.text = model.invest_amount
        self.afterLab.text = model.all_amount
    
    }
    

    lazy var afterLab:UILabel = {()->UILabel in
        let label:UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#262B37")
        label.text = "尾部"
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var middleLab:UILabel = {()->UILabel in
        let label:UILabel = UILabel()
        label.text = "中部"
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#262B37")
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var nameLab:UILabel = {()->UILabel in
        let label:UILabel = UILabel()
        label.text = "名字"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#262B37")
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
