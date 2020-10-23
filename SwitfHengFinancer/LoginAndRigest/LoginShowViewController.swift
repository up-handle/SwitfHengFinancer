//
//  LoginShowViewController.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/6.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginShowViewController: UIViewController,UITextFieldDelegate {

    
   fileprivate var _eyeBtn:UIButton?
   fileprivate var _pwdTF:UITextField?
    fileprivate var _nameTF:UITextField?
   private var _loginBtn:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        //
        let loginTipLab:UILabel = UILabel(frame: CGRect(x: 35, y: 90, width: 200, height: 40))
        loginTipLab.font = UIFont.boldSystemFont(ofSize: 28)
        loginTipLab.textColor = UIColor.black
        loginTipLab.text = "登录理财师"
        loginTipLab.textAlignment = .left
        self.view.addSubview(loginTipLab)
        //
        let lonigSmallTipLab:UILabel = UILabel(frame: CGRect(x: 35, y:90+40, width: 200, height: 20))
        lonigSmallTipLab.text = "请输入您的手机号和登录密码"
        lonigSmallTipLab.font = UIFont.systemFont(ofSize: 14)
        lonigSmallTipLab.textColor = UIColor.lightGray
        lonigSmallTipLab.textAlignment = .left
        self.view.addSubview(lonigSmallTipLab)
        
        //
        let nameTF = UITextField(frame: CGRect(x: 35, y: 230, width: 305, height: 50))
        nameTF.backgroundColor = UIColor.white
        self.view.addSubview(nameTF)
        nameTF.placeholder = "请输入手机号"
        nameTF.clearButtonMode = .always
        nameTF.keyboardType = UIKeyboardType.numberPad
        //nameTF.clearsOnBeginEditing = true   //再次编辑就清空
        //nameTF.contentVerticalAlignment = .bottom
        let nameLineView:UIView = UIView(frame: CGRect(x: 0, y: 49, width: 305, height: 1))
        nameLineView.backgroundColor = UIColor(red: 195/255.0, green: 200/255.0, blue: 210/255.0, alpha: 1.0)
        nameTF.addSubview(nameLineView)
        _nameTF = nameTF
    
        let pwdTF = UITextField(frame: CGRect(x: 35, y: 285, width: 280, height: 50))
        pwdTF.backgroundColor = UIColor.white
        self.view.addSubview(pwdTF)
        pwdTF.placeholder = "请输入密码"
        pwdTF.clearButtonMode = .always
        pwdTF.delegate = self
        pwdTF.isSecureTextEntry = true
        pwdTF.keyboardType = UIKeyboardType.asciiCapable
        pwdTF.keyboardAppearance = UIKeyboardAppearance.default //键盘外观
        pwdTF.returnKeyType = UIReturnKeyType.done
        let pwdLineView:UIView = UIView(frame: CGRect(x: 0, y: 49, width: 305, height: 1))
        pwdLineView.backgroundColor = UIColor(red: 195/255.0, green: 200/255.0, blue: 210/255.0, alpha: 1.0)
        pwdTF.addSubview(pwdLineView)
        _pwdTF = pwdTF
        
        //右侧添加图片
        _eyeBtn = UIButton(type: .custom)
        _eyeBtn?.setImage(UIImage.init(named:"close_state"), for: .normal)
        _eyeBtn?.frame = CGRect(x: 320, y:303, width: 20, height: 20)
        _eyeBtn?.isSelected = false
        _eyeBtn?.addTarget(self, action: #selector(pwdEyeClickBtn), for: .touchUpInside)
        self.view.addSubview(_eyeBtn!)
        
//        pwdTF.rightView = _eyeBtn
//        pwdTF.rightViewMode = .always
        
        //
        let loginBtn:UIButton = UIButton(type:.custom);
        loginBtn.frame = CGRect(x: 35, y: 380, width: UIScreen.main.bounds.width - 70, height: 46)
//        loginBtn.backgroundColor = UIColor(red: 89/255.0, green: 125/255.0, blue: 255/255.0, alpha: 1.0)
        loginBtn.backgroundColor = UIColor.gray
        loginBtn .setTitle("登 录", for:.normal)
        loginBtn.addTarget(self, action:#selector(loginBtnClickToLogin), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        loginBtn.layer.cornerRadius = 23
        _loginBtn = loginBtn
        
        //快速注册
        let fastRegisterBtn = UIButton(type:UIButton.ButtonType.custom)
        fastRegisterBtn.frame = CGRect(x: 35, y: 450, width: 60, height: 20)
        fastRegisterBtn.setTitle("快速注册", for: .normal)
        fastRegisterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        fastRegisterBtn .setTitleColor(UIColor.darkGray, for: .normal)
        self.view.addSubview(fastRegisterBtn)
        //忘记密码
        let forgetBtn = UIButton(type:.custom)
        forgetBtn.frame = CGRect(x: UIScreen.main.bounds.width-100, y: 450, width: 60, height: 20)
        forgetBtn.setTitle("忘记密码", for: .normal)
        forgetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgetBtn .setTitleColor(UIColor.darkGray, for: .normal)
        self.view.addSubview(forgetBtn)

    }

    //textFiled点击完成代理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text as Any)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == " " {//不能输入空格
            return false
        }
    
        if (((_nameTF?.text!.count)!>3)&&((_pwdTF?.text!.count)!>3)) {
             _loginBtn?.backgroundColor = UIColor(red: 89/255.0, green: 125/255.0, blue: 255/255.0, alpha: 1.0)
        }else{
            _loginBtn?.backgroundColor = UIColor.gray
        }
        
        return true
    }
    
    @objc func loginBtnClickToLogin(){
        print("点击了登录按钮")
        self.view .endEditing(true)
        //"username":"18310936666" , "password": "1234Qwer"
        NetWorkTool.makePostRequest(url: HFLoginApi, parameters:["username":"13100001001" , "password": "Qa111111"], successHandle: { (json) in
            //
//            let dataJson = json["data"]
            let userModel:UserModel = UserModel.init(jsonData: json)
            print("=====>登录成功---","\(userModel.token)")
            DispatchQueue.main.async {
                //发送通知
                NotificationCenter.default.post(name: Notification.Name(rawValue: "LoginSuccessNoti"), object: nil)
            }
        }, netWorkFailHandler: { (failReponse) in
            SVProgressHUD.showInfo(withStatus: "登录失败")
                   
        }) { (Error) in
           SVProgressHUD.showError(withStatus: "登录错误")
       }
    }
    
    
    @objc func pwdEyeClickBtn(){
        print("点击了明密文按钮")
        let button:UIButton = _eyeBtn!
        button.isSelected = !button.isSelected
        if button.isSelected {
           _pwdTF?.isSecureTextEntry = false
           _eyeBtn?.setImage(UIImage.init(named: "open_state"), for:.normal)
    
        }else{
           _pwdTF?.isSecureTextEntry = true
           _eyeBtn?.setImage(UIImage.init(named:"close_state"), for: .normal)
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    

}

