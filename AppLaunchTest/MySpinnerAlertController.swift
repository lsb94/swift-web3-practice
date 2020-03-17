//
//  MySpinnerAlertController.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/16.
//  Copyright © 2020 dave lee. All rights reserved.
//
import UIKit

class MySpinnerAlertViewController {
    var alertController : UIAlertController!
    
    static let shared = MySpinnerAlertViewController()
    
    private init() {
        self.alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }
    
    internal func presentSpinner(title: String?) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        alertController.view.addSubview(activityIndicator)
        alertController.view.heightAnchor.constraint(equalToConstant: 95).isActive = true
        alertController.view.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude).isActive = true
        alertController.title = title
        
        activityIndicator.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -20).isActive = true
        
        
        guard var topViewController =  UIApplication.shared.keyWindow?.rootViewController else {
            print("topview : nil")
            return
        }
        while topViewController.presentedViewController != nil {
            topViewController = topViewController.presentedViewController!
        }
        topViewController.present(alertController, animated: true, completion: nil)
    }
    
    internal func dismissSpinner() {
        self.alertController.dismiss(animated: true, completion: nil)
    }
}
