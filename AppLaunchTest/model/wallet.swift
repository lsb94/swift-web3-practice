//
//  wallet.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/13.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation

class wallet {
    var address: String
    
    
    init (address: String) {
        self.address = address
    }
    
    static var dummyWalletList = [
        wallet(address: "")
    ]
    
}
