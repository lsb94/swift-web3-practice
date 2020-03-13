//
//  MyPassword.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/12.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation
import UIKit

typealias verifyResult = (Bool, String?, String?) -> Void
class MyPassword {
    /**
     패스워드를 입력받는 alert창을 생성하는 함수
     */
    static func inputPassword (onCompletion : @escaping(verifyResult)) {

        let description = "지갑의 개인키를 안전히 보관하기 위한 암호를 입력하세요"

        let alertController = UIAlertController(title: "암호 생성", message: description, preferredStyle: .alert)
        weak var textPassword: UITextField!
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.keyboardType = .numberPad
            textPassword = textField
        })
        alertController.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { action in
            let password = textPassword.text ?? ""
            if password == "" {
                self.inputPassword() { (result, password, error) in
                    onCompletion(result, password, error)
                }
            } else {
                verifyPassword(password: password) { (result, password, error) in
                    onCompletion(result, password, error)
                }
            }
        }))
        guard var topViewController =  UIApplication.shared.keyWindow?.rootViewController else {
            print("topview : nil")
            return
        }
        while topViewController.presentedViewController != nil {
            topViewController = topViewController.presentedViewController!
        }
        topViewController.present(alertController, animated: true, completion: nil)
    }
    
    private static func verifyPassword (password: String, onCompletion: @escaping(verifyResult)) {

        let description = "암호를 한번 더 입력하세요"

        let alertController = UIAlertController(title: "암호 확인", message: description, preferredStyle: .alert)
        weak var textPassword: UITextField!
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Password Verify"
            textField.isSecureTextEntry = true
            textField.keyboardType = .numberPad
            textPassword = textField
        })
        alertController.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { action in
            if textPassword.text == password {
                print("verifyPassword: 패스워드 인증 성공")
                
                onCompletion(true, password, nil)
            } else {
                print("verifyPassword: 패스워드 인증 실패")
                onCompletion(false, nil, "패스워드가 틀립니다")
            }
        }))
        guard var topViewController =  UIApplication.shared.keyWindow?.rootViewController else {
            print("topview : nil")
            return
        }
        while topViewController.presentedViewController != nil {
            topViewController = topViewController.presentedViewController!
        }
        topViewController.present(alertController, animated: true, completion: nil)
    }
    
}
