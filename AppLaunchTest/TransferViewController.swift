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

    //textfield
    @IBOutlet weak var textSymbol: UITextField!
    @IBOutlet weak var textContract: UITextField!
    @IBOutlet weak var textBalance: UITextField!
    @IBOutlet weak var textAddressTo: UITextField!
    @IBOutlet weak var textAmount: UITextField!
    
    //navigate bar
    @IBAction func buttonSend(_ sender: Any) {
        guard let balance = textBalance.text else { return print("balance empty") }
        guard let amount = textAmount.text else { return print("amount empty") }
        guard let tokenAddress = textContract.text else { return print("contract address empty") }
        guard let sendTo = textAddressTo.text else { return print("wallet address empty") }
        guard let balanceNum = BigUInt(balance),
            let amountNum = BigUInt(amount)
            else { return print("bigUint fail") }
        if balanceNum > amountNum {
            print("send button act")
            let token = ContractERC20(web3: web3, contractAddress: tokenAddress)
            token.sendTokenTo(address: sendTo, amount: amountNum)
        } else {
            alert(title: "잔액 부족", message: "잔액이 부족합니다.")
            return
        }
        self.navigationController?.popViewController(animated: true)
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
    
    // web3 inintialize
    let web3 = Web3(rpcURL: "https://ropsten.infura.io/v3/45d946bade934f1a8d099e0d219884e6")
}
