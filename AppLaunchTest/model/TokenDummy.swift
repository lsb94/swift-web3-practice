//
//  Token.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/12.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation

class TokenDummy {
    var balanceDummy: String
    var symbolDummy: String
    var addressDummy: String

    init(balance: String, symbol: String, address: String){
        self.balanceDummy = balance
        self.symbolDummy = symbol
        self.addressDummy = address
    }

    static var dummyTokenList = [
        TokenDummy(balance: "unknown", symbol: "ZEENUS", address: "0xC84f8B669Ccb91C86AB2b38060362b9956f2De52"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB"),
        TokenDummy(balance: "1", symbol: "2", address: "0x3365E9f3D0712558Be67A6eb181D09961260FCDB")]
}
