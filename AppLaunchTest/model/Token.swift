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
        Token(balance: "unknown", symbol: "ZEENUS", address: "0xC84f8B669Ccb91C86AB2b38060362b9956f2De52"),
        Token(balance: "1", symbol: "2", address: "3"),
        Token(balance: "1", symbol: "2", address: "3"),
        Token(balance: "1", symbol: "2", address: "3"),
        Token(balance: "1", symbol: "2", address: "3"),
        Token(balance: "1", symbol: "2", address: "3"),
        Token(balance: "1", symbol: "2", address: "3"),
        Token(balance: "1", symbol: "2", address: "3"),
        Token(balance: "1", symbol: "2", address: "3")
    ]
}
