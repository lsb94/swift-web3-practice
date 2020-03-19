//
//  CustomTokenViewController.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/18.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit

class CustomTokenViewController: UIViewController {

    @IBOutlet weak var labeltest: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labeltest.text = "0x0000000000000000000000000000000000000000"
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
