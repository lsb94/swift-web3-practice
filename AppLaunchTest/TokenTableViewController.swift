//
//  TokenTableViewController.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/11.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3
import Keystore


@available(iOS 11.0, *)
class TokenTableViewController: UITableViewController {

    @IBAction func buttonEncrytionTest(_ sender: Any) {
        do {
            guard let text = "this is my secret.".data(using: .utf8) else {
                print("!! data is malformatted")
                return
            }
            try MySecureEnclave.shared.createSecKey()

            let privateKey = try MySecureEnclave.shared.loadSecKey()
            try MySecureEnclave.shared.encrypt(privateKey: privateKey, target: text )
        } catch{print(error)}
    }
    @IBAction func buttonDecryptionTest(_ sender: Any) {
        do {
            print("1")
            let privateKey = try MySecureEnclave.shared.loadSecKey()
            print("2")
            let result = try MySecureEnclave.shared.decrypt(privateKey: privateKey)
            print("3x")
            print(String(decoding: result as Data, as: UTF8.self))
        } catch{print(error)}
    }
    @IBAction func buttonBioTest(_ sender: Any) {
        let bio = MyBioAuthentication()
        bio.myBio { (result, error) in
            print("뷰 컨트롤러: \(result)")
            let errorText = error ?? ""
            print(errorText)
        }
    }
    //navigate bar
    @IBOutlet weak var labelWallet: UILabel!
    @IBOutlet weak var labelEth: UILabel!
    
    @IBAction func buttonVersionCheck(_ sender: Any) {
        var versionInfo: String = ""
        
                firstly {
                    web3.net.version()
                }.done {version in
                    versionInfo += "\nnetwork version: \n" + version + "\n"
                }.catch {error in
                    versionInfo += "\nnetwork version: \nerror\n"
                }
                firstly {
                    web3.clientVersion()
                }.done {version in
                    versionInfo += "\nclient version: \n" + version + "\n"
                }.catch {error in
                    versionInfo += "\nclient version: \nerror\n"
                }
                
        //        alert(title: "Version Info", message: v)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.alert(title: "Version Info", message: versionInfo)
                }
 
    }
    
    @IBAction func buttonAddToken(_ sender: Any) {
        
    }
    
    //cell
    
    @IBAction func buttonCheckBalance(_ sender: Any) {
        
        let erc20 = ContractERC20(web3: web3, contractAddress: TokenDummy.dummyTokenList[0].addressDummy)
        let message = erc20.getBalanceOf(walletAddress: MyWallet.init().address) //여기에 이제 만든 월렛 어드레스 정보넣어야
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            let balance = erc20.getBalance()
            TokenDummy.dummyTokenList[0].balanceDummy = balance // index of tokenlist is fixed, need to be flexible.
            self.tableView.reloadData() // As-Is: whole table view is reloading, To-Be: only the cell will be reloaded(see below)
            //            self.tableView.reloadRows(at: 0, with: .none) // index path 0 does not work.
        }
    }
    
    
    @IBAction func buttonTransfer(_ sender: Any) {
    }
    
    
    //scene control
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstLaunch = FirstLaunch()
        if firstLaunch.isFirstLaunch{
//        if true {
            print("This is FIRST LAUNCH")
            let keySet = try! EthereumPrivateKey.init()
            let privateKey = keySet.rawPrivateKey
            print(privateKey.toHexString())
            let password = "1q2w3e"
            let keystore = try! Keystore(privateKey: privateKey, password: password)
            let keystoreJson = try! JSONEncoder().encode(keystore)
            UserDefaults.standard.set(keystoreJson, forKey: "keyJson") //private key store as json
            let addressEip = try! EthereumAddress(hex: keystore.address, eip55: false).hex(eip55: true)
            UserDefaults.standard.set(addressEip, forKey: "address") //eip55 address store as string
        }
        let address = MyWallet.init().address
        print(address)
        labelWallet.text = "\(address)"
        do {
            let etherAddress = try EthereumAddress.init(hex: address, eip55: false)
                web3.eth.getBalance(address: etherAddress, block: .latest) { response in
                    let balance = response.result?.quantity
//                    let balanceETH = response.result?.quantity.eth
//                    let balanceRaw = response.result?.quantity
//                    print(balanceRaw)
                    print(balance)
//                    print(balanceETH)
                    let ethereum = Double(balance!) / pow(10, 18)
                    DispatchQueue.main.async {
                        self.labelEth.text = String(ethereum)
                    }
                    
//                    DispatchQueue.main.async {
//                        self.labelEth.text = String(format: "%.9f", ethereum)
//                    }
                }
        } catch {print(error)}
    }
    
    // web3 inintialize
    let web3 = Web3(rpcURL: "https://ropsten.infura.io/v3/45d946bade934f1a8d099e0d219884e6")
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TokenDummy.dummyTokenList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellToken", for: indexPath) as! MyCustomTableViewCell

        // Configure the cell...
        let target = TokenDummy.dummyTokenList[indexPath.row]
        
        cell.labelBalance?.text = target.balanceDummy
        cell.labelSymbol?.text = target.symbolDummy

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
