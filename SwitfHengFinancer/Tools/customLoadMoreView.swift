//
//  customLoadMoreView.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

class LoadMoreView: MJRefreshBackFooter {
    
//    var loadingView: UIActivityIndicatorView?
    
    var arrowView:UIImageView?
    
    var stateLabel: UILabel?
    
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                self.stateLabel?.text = ""
                
            case .refreshing:
                self.arrowView?.isHidden = true
                self.stateLabel?.text = "拼命获取中..."
               
            case .noMoreData:
                self.arrowView?.isHidden = true
                self.stateLabel?.text = "已经没有更多数据"
            default:
                self.arrowView?.isHidden = false
                self.stateLabel?.text = "上拉获取更多"
                break
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        self.mj_h = 50
        //
        self.arrowView = UIImageView.init(image: UIImage.init(named: "refreshmore"))
        self.arrowView?.contentMode = .scaleAspectFit
        self.addSubview(self.arrowView!)
        //
        self.stateLabel = UILabel()
        self.stateLabel?.textAlignment = .center
        self.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        self.stateLabel?.textColor = UIColor(red: 148/255.0, green: 150/255.0, blue: 163/255.0, alpha: 1.0)
        self.addSubview(stateLabel!)
        //
//        self.loadingView = UIActivityIndicatorView(style: .medium)
//        self.addSubview(loadingView!)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        let width = UIScreen.main.bounds.width
        self.stateLabel?.sizeToFit()
        let frame:CGRect = self.stateLabel!.frame
        self.stateLabel?.frame = CGRect(x: width/2-frame.size.width/2, y: (self.frame.size.height - frame.size.height)/2, width: frame.size.width, height: frame.size.height)
        self.arrowView?.frame = CGRect(x: (self.stateLabel?.frame.origin.x)! - 23, y: (self.frame.size.height-17)/2, width: 17, height: 17)
    }
    
    override func endRefreshing() {
        if self.state == .noMoreData {
            return
        }
        self.state = .idle
    }
    
    
    
    

}
