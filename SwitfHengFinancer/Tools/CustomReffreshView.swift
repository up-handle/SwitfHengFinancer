//
//  CustomReffreshView.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh



class RefreshView: MJRefreshHeader {
    
    // 转圈的菊花
    var loadingView: UIActivityIndicatorView?
    
    var loadingLab: UILabel?
    // 下拉的icon
    var arrowImage: UIImageView?
    
    // 处理不同刷新状态下的组件状态
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                
                self.loadingLab?.text = "下拉刷新"
                if oldValue == .refreshing {
                    self.loadingLab?.text = ""
                    self.arrowImage?.transform = .identity
                    
                    UIView.animate(withDuration: TimeInterval(MJRefreshSlowAnimationDuration), animations: {
                        self.loadingView?.alpha = 0.0
                    }) { (finished) in
                        // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                        if(self.state != .idle) {
                            return
                        }
                        self.loadingView?.alpha = 1.0
                        self.loadingView?.stopAnimating()
                        self.arrowImage?.isHidden = false
                        self.loadingLab?.text = "下拉刷新"
                    }
                } else{
                    self.loadingView?.stopAnimating()
                    self.arrowImage?.isHidden = false
                    self.loadingLab?.text = "下拉刷新"
                    UIView.animate(withDuration: TimeInterval(MJRefreshSlowAnimationDuration)) {
                        self.arrowImage?.transform = .identity
                    }
                }
                
            case .pulling:
                
                self.loadingLab?.text = "松开刷新"
                self.loadingView?.stopAnimating()
                self.arrowImage?.isHidden = false
                UIView.animate(withDuration: TimeInterval(MJRefreshSlowAnimationDuration)) {
                    self.arrowImage?.transform = CGAffineTransform.init(rotationAngle: CGFloat(0.00001 - Double.pi))
                }

            case .refreshing:
              
                self.loadingLab?.text = ""
                self.loadingView?.alpha = 1.0 // 防止refreshing -> idle的动画完毕动作没有被执行
                self.loadingView?.startAnimating()
                self.arrowImage?.isHidden = true
                
            default:
                print("")
            }
        }
    }
    
    // 初始化组件
    override func prepare() {
        super.prepare()
        self.mj_h = 50
        //
        self.loadingLab = UILabel()
        self.loadingLab?.font = UIFont.systemFont(ofSize: 12)
        self.loadingLab?.textColor = UIColor(red: 148/255.0, green: 150/255.0, blue: 163/255.0, alpha: 1.0)
        self.addSubview(self.loadingLab!)
        self.loadingLab?.text = "下拉刷新"
        self.endRefreshing {
            self.loadingLab?.text = "下拉刷新"
            self.placeSubviews()
        }
        //
        self.arrowImage = UIImageView(image: UIImage(named: "refreshpull"))
        self.arrowImage?.contentMode = .scaleAspectFit
        self.addSubview(arrowImage!)
        //
        self.loadingView = UIActivityIndicatorView(style:.gray)
        self.addSubview(loadingView!)

        
    }
    
    // 组件定位
    override func placeSubviews() {
        super.placeSubviews()
        let width = UIScreen.main.bounds.width
        self.loadingLab?.sizeToFit()
        let frame:CGRect = self.loadingLab!.frame
        self.loadingLab?.frame = CGRect(x: width/2-frame.size.width/2, y: (self.frame.size.height - frame.size.height)/2, width: frame.size.width, height: frame.size.height)
        self.arrowImage?.frame = CGRect(x: (self.loadingLab?.frame.origin.x)! - 23, y: (self.frame.size.height-17)/2, width: 17, height: 17)
        self.loadingView?.frame = CGRect(x: width/2-10, y: self.frame.size.height/2-10, width: 20, height: 20)

    }

}
