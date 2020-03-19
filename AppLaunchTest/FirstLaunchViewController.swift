//
//  FirstLaunchViewController.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/13.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3
import Keystore

class FirstLaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("first?")
        let firstLaunch = FirstLaunch()
        if firstLaunch.isFirstLaunch{
//                    if true {
            print("This is FIRST LAUNCH")
            var password : String!
            MySpinnerAlertViewController.shared.presentSpinner(title: "지갑 생성중입니다.")
            DispatchQueue.global().sync {
                MyPassword.inputPassword() { (result, password, error) in
                    if result { // passsword is "something", error is nil
                        let myPassword = password!
                        do {
                            //이더리움 개인키 생성
                            print("첫 실행: 지갑 개인키 생성 시작...")
                            let keySet = try EthereumPrivateKey.init()
                            let privateKey = keySet.rawPrivateKey
                            print("첫 실행: 지갑 개인키 생성 완료 : \n\(privateKey.toHexString())")
                            
                            // 개인키와 패스워드로 키스토어(이더리움 키셋) 생성 및 저장
                            print("첫 실행: 키스토어 생성 시작...")
                            let keystore = try Keystore(privateKey: privateKey, password: myPassword)
                            let keystoreJson = try JSONEncoder().encode(keystore)
                            print("첫 실행: 키스토어 생성 완료")
                            UserDefaults.standard.set(keystoreJson, forKey: "keyJson") //private key store as json
                            
                            //Secure Enclave 키 생성 및 로드
                            print("첫 실행: SE 키 생성 시작...")
                            try MySecureEnclave.shared.createSecKey()
                            let securePrivateKey = try MySecureEnclave.shared.loadSecKey()
                            print("첫 실행: SE 키 생성 완료")
                            
                            //Secure Enclave 키로 패스워드 암호화 후 암호화 된 패스워드 저장
                            print("첫 실행: 패스워드 저장 시작...")
                            let passwordData = myPassword.data(using: .utf8.self)!
                            try MySecureEnclave.shared.encrypt(privateKey: securePrivateKey, target: passwordData)
                            print("첫 실행: 패스워드 저장 완료")
                            // 이더리움 주소 저장
                            print("첫 실행: 지갑 주소 저장 시작...")
                            let addressEip = try EthereumAddress(hex: keystore.address, eip55: false).hex(eip55: true)
                            UserDefaults.standard.set(addressEip, forKey: "address") //eip55 address store as string
                            print("첫 실행: 지갑 주소 저장 완료")
                            
                            //스피너 디스미스
                            MySpinnerAlertViewController.shared.dismissSpinner()
                            
                            //다음 뷰컨트롤러 호출
                            self.performSegue(withIdentifier: "segueToTokenTableVC", sender: nil)
                        } catch {
                            MySpinnerAlertViewController.shared.dismissSpinner()
                            print(error)
                            
                        }
                    } else { // password is nil, error is "something"
                        MySpinnerAlertViewController.shared.dismissSpinner()
                        
                        print("password initiation fail: \n\(error!)")
                        let alert = UIAlertController(title: "비밀번호 설정 실패", message: "비밀번호 설정에 실패하여 앱을 정지합니다.", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
            }//SYNC
        } else {
            //다음 뷰컨트롤러 호출
//            self.performSegue(withIdentifier: "segueToTokenTableVC", sender: nil)
            let nextVC = CustomTokenViewController.init(nibName: "CustomTokenViewController", bundle: nil)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }x
     */
    
}
