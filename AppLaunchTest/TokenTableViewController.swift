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


class TokenTableViewController: UITableViewController {

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
        
        let erc20 = ContractERC20(web3: web3, contractAddress: Token.dummyTokenList[0].address)
        let message = erc20.getBalanceOf(walletAddress: MyWallet.init().address) //여기에 이제 만든 월렛 어드레스 정보넣어야
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            let balance = erc20.getBalance()
            Token.dummyTokenList[0].balance = balance // index of tokenlist is fixed, need to be flexible.
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
            print(privateKey)
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
                    let balance = response.result?.quantity.gwei
                    let ethereum = Double(balance!) / pow(10, 27)
                    print(String(format: "%.9f", ethereum))
                    
                    DispatchQueue.main.async {
                        self.labelEth.text = String(format: "%.9f", ethereum)
                    }
                }
        } catch {print(error)}
    }
    
    // web3 inintialize
    let web3 = Web3(rpcURL: "https://ropsten.infura.io/v3/45d946bade934f1a8d099e0d219884e6")
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Token.dummyTokenList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellToken", for: indexPath) as! MyCustomTableViewCell

        // Configure the cell...
        let target = Token.dummyTokenList[indexPath.row]
        
        cell.labelBalance?.text = target.balance
        cell.labelSymbol?.text = target.symbol
//        cell.textLabel?.text = target.balance
//        cell.detailTextLabel?.text = target.symbol

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
