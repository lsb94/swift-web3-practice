//
//  MyWeb3.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/16.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation
import Web3

class MyWeb3 {
    var web3 : Web3
    
    static var shared = MyWeb3()
    
    private init () {
        self.web3 = Web3(rpcURL: "https://ropsten.infura.io/v3/45d946bade934f1a8d099e0d219884e6")
    }
}
