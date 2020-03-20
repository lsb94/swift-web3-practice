//
//  CustomTokenTransferViewController.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/19.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import BigInt

class CustomTokenTransferViewController: UIViewController {
    
    //pushed cell
    var cell : CustomTokenCollectionViewCell?

    //outlet
    @IBOutlet weak var textSymbol: UITextField!
    @IBOutlet weak var textTokenAddress: UITextField!
    @IBOutlet weak var textBalance: UITextField!
    @IBOutlet weak var textAmount: UITextField!
    @IBOutlet weak var textTo: UITextField!
    
    //button
    @IBAction func buttonQR(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        guard let index = cell?.indexPath?.row else{
            return
        }
        super.viewDidLoad()
    
        self.navigationItem.title = "Token Transfer"
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Send", style: .done , target: self, action: #selector(buttonSend)), animated: true)
        
        let token = TokenDummy.dummyTokenList[index] // As-Is: fixed token info, To-Be: get pathIndex from button to flexible info
        textSymbol.text = token.symbolDummy
        textTokenAddress.text = token.addressDummy
        textBalance.text = token.balanceDummy
    }
    
    @objc func buttonSend() {
        print("send")
        guard let balance = textBalance.text else { return print("balance empty") }
        guard let amount = textAmount.text else { return print("amount empty") }
        guard let tokenAddress = textTokenAddress.text else { return print("contract address empty") }
        guard let sendTo = textTo.text else { return print("wallet address empty") }
        guard let balanceNum = BigUInt(balance) else { return print("bigUint fail") }
        guard let amountNum: BigUInt = BigUInt((amount)) else { return print("bigUint fail") }
        
        if balanceNum >= amountNum {
            MySpinnerAlertViewController.shared.presentSpinner(title: "트랜잭션을 전송중입니다.")
            DispatchQueue.global().async {
                let token = ContractERC20(web3: MyWeb3.shared.web3, contractAddress: tokenAddress)
                token.sendTokenTo(address: sendTo, amount: amountNum) { (result, message) in
                    if result {
                        DispatchQueue.main.async {
                            MySpinnerAlertViewController.shared.dismissSpinner()
                        }
                        print(message!)
                        
                        let alert = UIAlertController(title: "트랜잭션 전송 성공", message: message, preferredStyle: .alert)
                        let buttonOk = UIAlertAction.init(title: "확인", style: .cancel) { action in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(buttonOk)
                        
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                    }else {
                        DispatchQueue.main.async {
                            MySpinnerAlertViewController.shared.dismissSpinner()
                        }
                        let alert = UIAlertController(title: "트랜잭션 전송 실패", message: message, preferredStyle: .alert)
                        let buttonOk = UIAlertAction.init(title: "확인", style: .cancel) { action in
//                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(buttonOk)
                        
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        } else {
            alert(title: "잔액 부족", message: "잔액이 부족합니다.")
            return
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
