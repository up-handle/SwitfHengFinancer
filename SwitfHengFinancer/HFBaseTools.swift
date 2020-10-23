//
//  HFBaseTools.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/12.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import Foundation


//高度
let projectBgColor:UIColor = UIColor.hexadecimalColor(hexadecimal: "#F9F9F9")

let ScreenWidth:CGFloat = UIScreen.main.bounds.width

let ScreenHeight:CGFloat = UIScreen.main.bounds.height

//

//获取状态栏的高度，全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt
let statusBarHeight = UIApplication.shared.statusBarFrame.height;

//导航栏单纯高度
let navigationHeight:CGFloat = 44.0

//导航栏和状态栏高度
let navigationAllHeight:CGFloat = (statusBarHeight + 44.0)

//tabbar高度
let tabBarHeight:CGFloat = (statusBarHeight==44.0 ? 83.0 : 49.0)

//顶部的安全距离
let topSafeAreaHeight = (statusBarHeight - 20.0)
//底部的安全距离，全面屏手机为34pt，非全面屏手机为0pt
let bottomSafeAreaHeight = (tabBarHeight - 49.0)




func log<T>(_ msg:T,
            file:NSString = #file,
            line:Int = #line,
            fn:String = #function){
    #if DEBUG
    let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
    print(prefix,msg)
    #endif

}


class HFBaseTools: NSObject {
    
    
    //随机颜色
    public static func getRandomNumber(_ from: UInt32, _ to: UInt32) -> UInt32 {
         return (from + (arc4random() % (to - from + 1)))
    }
       
    public static func getRandomColor() -> UIColor {
        let r: UInt32 = arc4random_uniform(255)
        let g: UInt32 = arc4random_uniform(255)
        let b: UInt32 = arc4random_uniform(255)
       
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }

    
    //传入颜色生成图片
    static  func creatImageWithColor(color:UIColor)->UIImage{
           let rect = CGRect(x:0,y:0,width:1,height:1)
           UIGraphicsBeginImageContext(rect.size)
           let context = UIGraphicsGetCurrentContext()
           context?.setFillColor(color.cgColor)
           context!.fill(rect)
           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return image!
       }
    

}
