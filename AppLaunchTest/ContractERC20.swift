//
//  ERC20Function.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/11.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3

class ContractERC20 {
    var _web3: Web3
    var _contractAddress: EthereumAddress
    var _contract: GenericERC20Contract
    var _balance: String = "2"
    
    init (web3: Web3, contractAddress: String) {
        self._web3 = web3
        self._contractAddress = try! EthereumAddress(hex: contractAddress, eip55: true)
        self._contract = web3.eth.Contract(type: GenericERC20Contract.self, address: self._contractAddress)
//        self._balance = "3"
    }
    
    func getBalance() -> String{
        return self._balance
    }
    func setBalance(amount: String) {
        self._balance = amount
    }
    
    func getBalanceOf(walletAddress: String) {
    // Get balance of some address
        firstly {
            try self._contract.balanceOf(address: EthereumAddress(hex: walletAddress, eip55: true)).call()
        }.done { outputs in
            print(outputs["_balance"] as? BigUInt)
            self._balance = String(outputs["_balance"] as! BigUInt)
        }.catch { error in
            print(error)
        }
    }


    func sendTokenTo(address: String, amount: BigUInt) {
        // Send some tokens to another address (locally signing the transaction)
        let myPrivateKey = try! EthereumPrivateKey(hexPrivateKey: "...")
        firstly {
            self._web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest)
        }.then { nonce in
            try self._contract.transfer(to: EthereumAddress(hex: address, eip55: true), value: amount).createTransaction(
                nonce: nonce,
                from: myPrivateKey.address,
                value: 0,
                gas: 100000,
                gasPrice: EthereumQuantity(quantity: 21.gwei)
                )!.sign(with: myPrivateKey).promise
        }.then { tx in
            self._web3.eth.sendRawTransaction(transaction: tx)
        }.done { txHash in
            print(txHash)
        }.catch { error in
            print(error)
        }
    }
}
