//
//  CustomTokenTransferViewController.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/19.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit

class CustomTokenTransferViewController: UIViewController {

    //outlet
    @IBOutlet weak var textSymbol: UITextField!
    @IBOutlet weak var textAddress: UITextField!
    @IBOutlet weak var textBalance: UITextField!
    @IBOutlet weak var textAmount: UITextField!
    
    //button
    @IBAction func buttonQR(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Token Transfer"
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Send", style: .done , target: self, action: #selector(buttonSend)), animated: true)
    }
    
    @objc func buttonSend() {
        print("send")
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
