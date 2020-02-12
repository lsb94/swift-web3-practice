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
    
    init(balance: String, symbol: String){
        self.balance = balance
        self.symbol = symbol
    }
    
    static var dummyTokenList = [
        Token(balance: "123,456,789.098", symbol: "ABC"),
        Token(balance: "123,456,789.098", symbol: "CDE")
    ]
}
