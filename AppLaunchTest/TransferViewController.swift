//
//  TransferViewController.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/13.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3


class TransferViewController: UIViewController {

    //outlet
    @IBOutlet weak var textSymbol: UITextField!
    @IBOutlet weak var textContract: UITextField!
    @IBOutlet weak var textBalance: UITextField!
    @IBOutlet weak var textAddressTo: UITextField!
    @IBOutlet weak var textAmount: UITextField!
    @IBOutlet weak var indicatorSend: UIActivityIndicatorView!
    
    //navigate bar
    @IBAction func buttonSend(_ sender: Any) {
        guard let balance = textBalance.text else { return print("balance empty") }
        guard let amount = textAmount.text else { return print("amount empty") }
        guard let tokenAddress = textContract.text else { return print("contract address empty") }
        guard let sendTo = textAddressTo.text else { return print("wallet address empty") }
        guard let balanceNum = BigUInt(balance) else { return print("bigUint fail") }
        guard let amountNum: BigUInt = BigUInt((amount)) else { return print("bigUint fail") }
    
        if balanceNum >= amountNum {
            MySpinnerAlertViewController.shared.popSpinner(title: "트랜잭션을 전송중입니다.")
            DispatchQueue.global().async {
                let token = ContractERC20(web3: MyWeb3.shared.web3, contractAddress: tokenAddress)
                token.sendTokenTo(address: sendTo, amount: amountNum) { (result, message) in
                    if result {
                        MySpinnerAlertViewController.shared.dismissSpinner()
                        
                        let alert = UIAlertController(title: "트랜잭션 전송 성공", message: message, preferredStyle: .alert)
                        let buttonOk = UIAlertAction.init(title: "확인", style: .cancel) { action in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(buttonOk)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }else {
                        MySpinnerAlertViewController.shared.dismissSpinner()
                        
                        let alert = UIAlertController(title: "트랜잭션 전송 실패", message: message, preferredStyle: .alert)
                        let buttonOk = UIAlertAction.init(title: "확인", style: .cancel) { action in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(buttonOk)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            }
        } else {
            alert(title: "잔액 부족", message: "잔액이 부족합니다.")
            return
        }
    }
    
    //scene control
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let token = TokenDummy.dummyTokenList[0] // As-Is: fixed token info, To-Be: get pathIndex from button to flexible info
        textSymbol.text = token.symbolDummy
        textContract.text = token.addressDummy
        textBalance.text = token.balanceDummy
    }
}
