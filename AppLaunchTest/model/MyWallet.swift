//
//  Wallet2.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/17.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation

class MyWallet {
    var address: Any
    
    init(){
        self.address = UserDefaults.standard.value(forKey: "keyJson")
        
    }
}
