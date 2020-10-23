//
//  NetWorkAfnTools.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/8.
//  Copyright © 2020 APPLE. All rights reserved.
//

/**
 //Alamofire 二次封装
 //https://www.jianshu.com/p/fd3672151539
 //自定义的SessionManager-参考
 //https://blog.csdn.net/u011146511/article/details/79158808
 */

import UIKit

import Alamofire
import SwiftyJSON
import SVProgressHUD


//MARK:网络环境的设置

enum MethodType {
    case get
    case post
}


enum  NetworkEnvironment{
    case Development
    case Test
    case Distribution
}

//// base服务
private var ProgressBase_Url = ""
private var isProdiction = false
private var appSecret:String = ""
private var appID = "xh-ios"
private var appVER = "1.1"
private var clientEnvironment = ""
//
private var isEncrypt = false
let CurrentNetWork : NetworkEnvironment = .Test

private func judgeNetwork(network : NetworkEnvironment = CurrentNetWork){

    if(network == .Development){
        ProgressBase_Url = "http://dev-***.com:8080/isp-kongming/"
    }else if(network == .Test){
        ProgressBase_Url = "http://dev-***.testcfbapi53.com/v1"
        isProdiction = false
        appSecret = isEncrypt ? "111111111" : "111111"
        clientEnvironment = "text"
    }else{
        ProgressBase_Url = "https://***.com/isp-kongming/"
    }
}


//MARK:请求头的封装

fileprivate var apiV1:String = ""
//parameters的是否加密
fileprivate var bodyStr:String = ""

func getNetHeaderValue() ->[String:String]{
    
    let accessToken:String = UserModel().token
    //版本号
    let currentVersion:String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    //设备UUID
    let deviceName = UIDevice.current.identifierForVendor?.uuidString
    //系统版本
    let systemVersion = UIDevice.current.systemVersion
    //手机型号
    let name = UIDevice.current.name
    //
    let clientTnfo:String = "\(name)" + ":" + "\(systemVersion)" + ":" + "\(deviceName!)"
    
    //获取时间戳
    func getHeaderTimeStr () ->String{
        let now:CLong = CLong(NSDate().timeIntervalSince1970)
        let timeoff:CLong = UserModel.init().timestamp
        let timeShow :CLong = now + timeoff
        let string = String(timeShow)
        return string
    }

    //签名规则
    func getSignString() -> String{
        let sign :String = apiV1 + "|" + "1.0.0" + "|" + appID + "|" + appSecret + "|" + getHeaderTimeStr() + "|"  + accessToken + "|" + clientTnfo + "|" + currentVersion + "|" + bodyStr
        return sign.md5()
    }
    
    //请求头设置
    let headDic = [
        "x-access-token":accessToken,
        "x-v" :"1.0.0",
        "x-appid":appID,
        "x-ver":appVER,
        "x-client-info":clientTnfo,
        "x-client-version":currentVersion,
        "x-client-environment":clientEnvironment,
        "x-sign": getSignString(),
        //时间戳
        "x-t": getHeaderTimeStr()
    ]

    return headDic
}


//MARK:协议封装请求
protocol NetWorkToolDelegate {
    //get请求
    static func makeGetRequest(url:String,parameters:[String:Any],successHandle:@escaping(_ json:JSON) ->(), netWorkFailHandler:@escaping(_ errorMsg :String) ->(), errorHandler:@escaping(_ error :Error) ->() )
    //post请求
    static func makePostRequest(url:String,parameters:[String:Any],successHandle:@escaping(_ json:JSON) ->(), netWorkFailHandler:@escaping(_ errorMsg :String) ->(), errorHandler:@escaping(_ error :Error) ->() )
    
//    /*  图片上传 请求 * imageData : 图片二进制数组 */
    static func upDataIamgeRequest(baseUrl : String,parameters : [String : String],imageArr : [UIImage],successHandler: @escaping(_ dict:JSON) ->(),errorMsgHandler : @escaping(_ errorMsg : String) -> (),networkFailHandler: @escaping(_ error:Error) -> ())
    
}


//MARK:网络请求
extension NetWorkTool{
    
    //MARK: 图片上传
    static func upDataIamgeRequest(baseUrl : String,parameters : [String : String],imageArr : [UIImage],successHandler: @escaping(_ dict:JSON) ->(),errorMsgHandler : @escaping(_ errorMsg : String) -> (),networkFailHandler: @escaping(_ error:Error) -> ())
    {
        
        judgeNetwork();
        
        let URL = ProgressBase_Url + baseUrl
        
        let userCookies = UserDefaults.standard.object(forKey: "userCookies")
        
        var header : [String : String]?
        
        if(userCookies != nil){
            
            header = ["Cookie":"\(userCookies!)","Set-Cookie":"\(userCookies!)","X-Requested-With":"XMLHttpRequest","Content-Type" : "application/json; charset=utf-8"]
            
        }
        
        if(imageArr.count == 0){
            
            return;
        }

        let image = imageArr.first;
        let imageData = image!.jpegData(compressionQuality: 0.5)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(imageData!, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
            //如果需要上传多个文件,就多添加几个
            //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
            //......
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: URL, method: .post, headers: header) { (encodingResult) in
            
            // print(encodingResult)
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let value = response.result.value else { return }
                    let json = JSON(value)
                    //  print(json)
                    // 请求成功 但是服务返回的报错信息
                    guard json["errorCode"].intValue == 0 else {
                        
                        if(json["errorCode"].intValue == 50000){ // Token 过期重新登录
                            
                            errorMsgHandler(json["errorMsg"].stringValue)
                            
                            SVProgressHUD.showInfo(withStatus: "授权失效,请重新登录!")
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
                                
                            //
                            }
                            return
                        }
                        
                        errorMsgHandler(json["errorMsg"].stringValue)
                        return
                    }
                    
                    if json["result"].dictionary != nil{
                        
                        successHandler(json["result"]["data"])
                        return
                    }else{
                        
                        successHandler(json["data"])
                        return
                    }
                }
                /*
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
                */
                
            case .failure(let encodingError):
                
                networkFailHandler(encodingError)
                //打印连接失败原因
                //  print(encodingError)
                
            }
        }
    }
       
    //MARK: get请求
    static func makeGetRequest(url: String, parameters: [String : Any], successHandle: @escaping (JSON) -> (), netWorkFailHandler: @escaping (String) -> (), errorHandler: @escaping (Error) -> ())
    {
        
        judgeNetwork();
                
        let allUrl = ProgressBase_Url + url
        
        Alamofire.request(allUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
                print("resopnse===\(response)")
                
                guard response.result.isSuccess
                    else{
                    errorHandler(response.error!) //网络发生错误
                    return
                }
                //
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    //请求成功，但是服务器返回的报错失败
                    
                    guard json["errorCode"].intValue == 0 else {
                        
                        if (json["errorCode"].intValue == 5000) { //token过期
                            
                            netWorkFailHandler(json["errorMsg"].stringValue)
                            
                            SVProgressHUD.showInfo(withStatus: "token过期,请重新登录")

                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
                                //发送通知
                            }
                            return
                        }
                        //失败返回
                        netWorkFailHandler(json["errorMsg"].stringValue)
                        return
                    }
            
                    if json["result"].dictionary != nil {
                        //成功
                        successHandle(json["result"])
                        return
                    }else{
                        successHandle(json)
                        return
                    }
              }
          }
    }

    //MARK: post请求
    static func makePostRequest(url: String, parameters: [String : Any], successHandle: @escaping (JSON) -> (), netWorkFailHandler: @escaping (String) -> (), errorHandler: @escaping (Error) -> ())
    {
        
         let manager = SessionManager.default
         manager.delegate.sessionDidReceiveChallenge = {
            session,challenge in return
            (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust: challenge.protectionSpace.serverTrust!))
         }
        
         judgeNetwork();
         ////////////
         apiV1 = "/V1" + url
         bodyStr = dicValueString(parameters)!
        
         ////////////
         let allUrl = ProgressBase_Url + url
         //设置header
        let hfHeader:Dictionary = getNetHeaderValue()
        
//        print(hfHeader)
        
        MySVProgressHUD.showLoading("正在加载...")

        Alamofire.request(allUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: hfHeader).responseJSON { (response) in
            //
            MySVProgressHUD.hideNow()
            
//            print(response.response?.allHeaderFields as Any)
//            print(response);
            
            let headDic = response.response?.allHeaderFields ?? [:]
            
            let serverTimer:NSValue = NSValue( nonretainedObject: headDic["X-Timestamp"])
            getTimestampFrom(CLong(bitPattern: serverTimer.pointerValue))
            
            // 网络连接或者服务错误的提示信息
            guard response.result.isSuccess else
            {
                errorHandler(response.error!);
                SVProgressHUD.showInfo(withStatus:"请求发生错误")
                SVProgressHUD.dismiss(withDelay: 1.5)
                return
            }
            
            if let value = response.result.value {
            
                let json = JSON(value)
//                print(json)
                // 请求成功 但是服务返回的报错信息
                guard json["code"].intValue == 200 else {
                    
                    if(json["code"].intValue == 401){ // Token 过期重新登录
                        
                        netWorkFailHandler(json["msg"].stringValue)
                        
                        SVProgressHUD.showInfo(withStatus: json["msg"].stringValue)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        DispatchQueue.main.async{
                            print("11111");
                          //发送通知
                          NotificationCenter.default.post(name: Notification.Name(rawValue: "OutLoginNotiCationValue"), object: nil)
                        }
                        return
                    }
                    
                    netWorkFailHandler(json["msg"].stringValue)
                    SVProgressHUD.showInfo(withStatus: json["msg"].stringValue)
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    return
                }
               if json["result"].dictionary != nil{
                    
                    successHandle(json["result"]["data"])
                    return
                }else{
                    
                    successHandle(json["data"])
                    return
                }
            }
        }
    }
    
}


struct NetWorkTool:NetWorkToolDelegate{
    
}


//MARK:获取服务器返回的时间戳
func getTimestampFrom(_ serverTime:CLong) -> () {
    if serverTime == 0 {
        return;
    }
    let current:CLong = CLong(NSDate().timeIntervalSince1970)
    let timeOffset:CLong = serverTime - current
    let model:UserModel = UserModel.init()
    model.timestamp = timeOffset

}

// MARK: 字典转字符串
func dicValueString(_ dic:[String : Any]) -> String?{
     let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
     let str = String(data: data!, encoding: String.Encoding.utf8)
     return str
}

