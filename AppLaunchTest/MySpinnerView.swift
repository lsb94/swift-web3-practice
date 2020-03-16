//
//  MySpinnerView.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/16.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation
import UIKit

class MySpinner {
    var spinnerView : UIView!
    
    static var shared = MySpinner()
    private init () {
        
    }
    
    internal func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let spinner = UIActivityIndicatorView.init(style: .whiteLarge)
        spinner.startAnimating()
        spinner.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(spinner)
            onView.addSubview(spinnerView)
        }
        
        self.spinnerView = spinnerView
    }
    
    internal func removeSpinner() {
        DispatchQueue.main.async {
            self.spinnerView?.removeFromSuperview()
            self.spinnerView = nil
        }
    }
}
