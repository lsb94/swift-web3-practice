//
//  CustomTokenCollectionViewCell.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/19.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTokenCollectionViewCell: UICollectionViewCell {

    //outlet
    @IBOutlet weak var textTokenBalacne: UILabel!
    @IBOutlet weak var textTokenSymbol: UILabel!
    
    //actions
    @IBAction func buttonTokenBalanceCheck(_ sender: Any) {
        print("balance")
    }
    @IBAction func buttonTokenTransfer(_ sender: Any) {
        print("transfer")
    }
    @IBAction func buttonTokenImage(_ sender: Any) {
        print("image")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
