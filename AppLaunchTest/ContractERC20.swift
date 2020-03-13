//
//  ERC20Function.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/11.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3
import Keystore

class ContractERC20 {
    var _web3: Web3
    var _contractAddress: EthereumAddress
    var _contract: GenericERC20Contract
    var _balance: String = "Response delayed"
    
    init (web3: Web3, contractAddress: String) {
        self._web3 = web3
        self._contractAddress = try! EthereumAddress(hex: contractAddress, eip55: true)
        self._contract = web3.eth.Contract(type: GenericERC20Contract.self, address: self._contractAddress)
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
            try self._contract.balanceOf(address: EthereumAddress(hex: walletAddress, eip55: false)).call()
        }.done { outputs in
            print(outputs["_balance"] as? BigUInt)
            self._balance = String(outputs["_balance"] as! BigUInt)
        }.catch { error in
            print(error)
        }
    }
    
    /**
    Send some tokens to another address (locally signing the transaction)
     */
    func sendTokenTo(address: String, amount: BigUInt) {
//        let semaphore = DispatchSemaphore(value: 0)
        let keyStoreJson = UserDefaults.standard.value(forKey: "keyJson") as! Data
        do{
            //불러온 키스토어 디코딩
            let keyStore =  try JSONDecoder.init().decode(Keystore.self, from: keyStoreJson)
            
            //패스워드 복호화
            let privateKey = try MySecureEnclave.shared.loadSecKey()
            
            let result = try MySecureEnclave.shared.decrypt(privateKey: privateKey)
            let password = String(decoding: result as Data, as: UTF8.self)
            let myAddress = try EthereumAddress(hex: MyWallet.init().address, eip55: true)
            let toAddress = try EthereumAddress(hex: address, eip55: true)
            let myPrivateKey = try EthereumPrivateKey(hexPrivateKey: keyStore.privateKey(password: password).toHexString())
            var gasPrice : EthereumQuantity!
            _web3.eth.gasPrice(){ response in
                guard let price = response.result else {
                    return print("gas Price를 받아올 수 없습니다.")
                }
                gasPrice = price
            }
            
            firstly {
                self._web3.eth.getTransactionCount(address: myPrivateKey.address, block: .latest)
            }.then { nonce in
                try self._contract.transfer(to: EthereumAddress(hex: address, eip55: true), value: amount).createTransaction(
                    nonce: nonce,
                    from: myAddress,
                    value: 0,
                    gas: 100000,
                    gasPrice: gasPrice
                    )!.sign(with: myPrivateKey,chainId: 3).promise
            }.then { tx in
                self._web3.eth.sendRawTransaction(transaction: tx)
            }.done { txHash in
                print(txHash.hex())
            }.catch { error in
                print(error)
            }
        } catch {print("wrong!")}
    }
}

