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
        var v: String = ""
    
        firstly {
            web3.net.version()
        }.done {version in
            v += "\nnetwork version: \n" + version + "\n"
        }.catch {error in
            v += "\nnetwork version: \nerror\n"
        }
        firstly {
            web3.clientVersion()
        }.done {version in
            v += "\nclient version: \n" + version + "\n"
        }.catch {error in
            v += "\nclient version: \nerror\n"
        }
        
//        alert(title: "Version Info", message: v)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.alert(title: "Version Info", message: v)
        }
        
    }
    
    @IBAction func ButtonTest(_ sender: Any) {
        alert(title: "button test", message: "none")
    }
    
    
}

