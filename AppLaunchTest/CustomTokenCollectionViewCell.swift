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

    //unique id = address
    var address: String?
    var indexPath : IndexPath?
    
    //delegator
    weak var delegate : CustomTokenCollectionViewCellDelegate?
    
    //outlet
    @IBOutlet weak var textTokenBalacne: UILabel!
    @IBOutlet weak var textTokenSymbol: UILabel!
    
    //actions
    @IBAction func buttonTokenBalanceCheck(_ sender: Any) {
        if let address = self.address,
            let index = self.indexPath,
        let delegate = self.delegate {
            delegate.thisCellBalance(cell: self) }
        else {
            MyAlertOnTop.shared.presentAlert(title: "토큰 잔고확인 버튼", message: "토큰 정보를 확인할 수 없습니다")
        }
    }
    @IBAction func buttonTokenTransfer(_ sender: Any) {
        if let address = self.address,
            let index = self.indexPath,
        let delegate = self.delegate {
            delegate.thisCellTransfer(cell: self) }
        else{
            MyAlertOnTop.shared.presentAlert(title: "토큰 전송화면 버튼", message: "토큰 정보를 확인할 수 없습니다")
        }
    }
    @IBAction func buttonTokenImage(_ sender: Any) {
        print(address)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
    
protocol CustomTokenCollectionViewCellDelegate : AnyObject {
    func thisCellBalance(cell : CustomTokenCollectionViewCell )
    func thisCellTransfer(cell : CustomTokenCollectionViewCell )
}
