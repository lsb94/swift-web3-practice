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
        //저장된 주소 불러오기
        let address = UserDefaults.standard.value(forKey: "address") as! String
        //저장된 주소가 eip55를 지원하지 않을 경우를 대비하여 eip55 포맷으로 다시 변환
        self.address = try! EthereumAddress.init(hex: address, eip55: false).hex(eip55: true)
    }
}

