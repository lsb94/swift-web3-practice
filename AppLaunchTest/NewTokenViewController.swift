//
//  NewTokenViewController.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/13.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit

class NewTokenViewController: UIViewController {

    @IBAction func buttonCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var textMyAddress: UITextField!
    @IBOutlet weak var textTokenAddress: UITextField!
    @IBAction func buttonSave(_ sender: Any) {
        let addressMy = textMyAddress.text
        let addressToken = textTokenAddress.text
        
        TokenDummy.dummyTokenList.append(TokenDummy(balance: "0", symbol: "XYZ", address: addressToken!))
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textMyAddress.text = MyWallet.init().address
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
