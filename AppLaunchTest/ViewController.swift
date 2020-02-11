//
//  ViewController.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/11.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3
import PromiseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let web3 = Web3(rpcURL: "https://ropsten.infura.io/v3/45d946bade934f1a8d099e0d219884e6")
    
    @IBAction func ButtonVersionCheck(_ sender: Any) {
        var versionInfo: String = ""
    
        firstly {
            web3.net.version()
        }.done {version in
            versionInfo += "\nnetwork version: \n" + version + "\n"
        }.catch {error in
            versionInfo += "\nnetwork version: \nerror\n"
        }
        firstly {
            web3.clientVersion()
        }.done {version in
            versionInfo += "\nclient version: \n" + version + "\n"
        }.catch {error in
            versionInfo += "\nclient version: \nerror\n"
        }
        
//        alert(title: "Version Info", message: v)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.alert(title: "Version Info", message: versionInfo)
        }
        
    }
    
    @IBAction func balanceOf(_ sender: Any) {
        
        let erc20 = ContractERC20(web3: web3, contractAddress: "0x583cbBb8a8443B38aBcC0c956beCe47340ea1367")
        let balance = erc20.getBalanceOf(walletAddress: "0xE724113C268d23fcBD8fbdAE5cD9EC2946B6C5cb")
//        alert(title: "button test", message: "none")
//        self.alert(title: "Version Info", message: "\(balance)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
        self.alert(title: "balance", message: "\(erc20.getBalance())")
        }
    }
    
    @IBAction func transferTo(_ sender: Any) {
    }
    
}

