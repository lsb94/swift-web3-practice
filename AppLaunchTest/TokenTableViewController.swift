//
//  TokenTableViewController.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/11.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit
import Web3

class TokenTableViewController: UITableViewController {

    //navigate bar
    
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.alert(title: "Version Info", message: versionInfo)
                }
    }
    
    @IBAction func buttonAddToken(_ sender: Any) {
        
    }
    
    
    
    //cell
    
    @IBAction func buttonCheckBalance(_ sender: Any) {
        
        let erc20 = ContractERC20(web3: web3, contractAddress: "0x583cbBb8a8443B38aBcC0c956beCe47340ea1367")
        let message = erc20.getBalanceOf(walletAddress: "0xE724113C268d23fcBD8fbdAE5cD9EC2946B6C5cb")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            let balance = erc20.getBalance()
            self.alert(title: "balance", message: balance)
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
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