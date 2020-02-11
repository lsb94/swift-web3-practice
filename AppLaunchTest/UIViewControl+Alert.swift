//
//  UIViewControl+Alert.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/11.
//  Copyright © 2020 dave lee. All rights reserved.
//

import UIKit

extension UIViewController{
    func alert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(oKAction)
        
        present(alert, animated: true, completion: nil)
    }

}

