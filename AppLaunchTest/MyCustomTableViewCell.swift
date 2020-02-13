//
//  MyCustomTableViewCell.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/13.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var buttonBalance: UIButton!
    @IBOutlet weak var buttonTransfer: UIButton!
    @IBOutlet weak var imageToken: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
