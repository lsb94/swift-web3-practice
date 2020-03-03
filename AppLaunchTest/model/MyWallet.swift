//
//  Wallet2.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/17.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation

class MyWallet {
    public var address: String
    
    init(){
        self.address = UserDefaults.standard.value(forKey: "address") as! String
    }
    static let myWallet = MyWallet()
}
