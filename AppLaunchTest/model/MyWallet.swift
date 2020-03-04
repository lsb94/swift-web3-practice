//
//  Wallet2.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/17.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation
import Web3

class MyWallet {
    public var address: String
    
    init(){
        let address = UserDefaults.standard.value(forKey: "address") as! String
        print("MyWallet: EIP55 변환 전: \(address)")
        self.address = try! EthereumAddress.init(hex: address, eip55: false).hex(eip55: true)
        print("MyWallet: EIP55 변환 후: \(self.address)")
    }
}

