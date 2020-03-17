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
    
    //navigationbar actions
    @IBAction func buttonDecryptionTest(_ sender: Any) {
        do {
            let privateKey = try MySecureEnclave.shared.loadSecKey()
            let result = try MySecureEnclave.shared.decrypt(privateKey: privateKey)
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
    @IBAction func buttonMyQR(_ sender: Any) {
        guard let myAddress = labelWallet.text else {
            return
        }
        guard let qrImage = MyQRGenerator.generateQRCode(from: myAddress) else {
            return
        }
        let qrView = UIImageView(frame: CGRect(x: 35, y: -220, width: 200, height: 200))
        qrView.image = qrImage
        
        let alert = UIAlertController.init(title: "QR로 내 지갑주소 보기", message: myAddress, preferredStyle: .alert)
        alert.view.addSubview(qrView)
        alert.addAction(UIAlertAction.init(title: "확인", style: .cancel, handler: nil))
        
        MyAlertOnTop.shared.getTopViewController()?.present(alert, animated: true, completion: nil)
        
        
    }
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
    
    //view outlets
    @IBOutlet weak var labelWallet: UILabel!
    @IBOutlet weak var labelEth: UILabel!
    
    
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
        
        let address = MyWallet.init().address
        print(address)
        labelWallet.text = "\(address)"
        do {
            let etherAddress = try EthereumAddress.init(hex: address, eip55: true)
                web3.eth.getBalance(address: etherAddress, block: .latest) { response in
                    let balanceAsWei = response.result?.quantity
                    let balanceAsEth = Double(balanceAsWei!) / pow(10, 18)
                    DispatchQueue.main.async {
                        self.labelEth.text = String(balanceAsEth)
                    }
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
