//
//  Token.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/12.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation

class Token {
    var balance: String
    var symbol: String
    var address: String
    
    init(balance: String, symbol: String, address: String){
        self.balance = balance
        self.symbol = symbol
        self.address = address
    }
    
    static var dummyTokenList = [
        Token(balance: "unknown", symbol: "ZEENUS", address: "0xc84f8b669ccb91c86ab2b38060362b9956f2de52"),
        Token(balance: "123,456.789098", symbol: "ETH", address: "0xdummy")
    ]
}
