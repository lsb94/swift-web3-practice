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
        Token(balance: "777.777", symbol: "BTC", address: "0xE724113C268d23fcBD8fbdAE5cD9EC2946B6C5cb"),
        Token(balance: "123,456.789098", symbol: "ETH", address: "0xdummy")
    ]
}
