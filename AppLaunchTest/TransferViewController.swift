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
        textBalance.text = "0"
        guard try!(Int(textBalance.text!)!) > 0 else {
            alert(title: "Develope Not done", message: "The function is not implemented yet.")
            return
        }
        let token = ContractERC20(web3: web3, contractAddress: textContract.text!)
        token.sendTokenTo(address: textAddressTo.text!, amount: try!(BigUInt(textAmount.text!)))
    }
    
    
    //scene control
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // web3 inintialize
    
    let web3 = Web3(rpcURL: "https://ropsten.infura.io/v3/45d946bade934f1a8d099e0d219884e6")
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
