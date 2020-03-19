//
//  MyAlertOnTop.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/16.
//  Copyright © 2020 dave lee. All rights reserved.
//
import UIKit

class MyAlertOnTop {
    var alertController : UIAlertController!
    
    static let shared = MyAlertOnTop()
    
    private init() {
        self.alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }
    
    func getTopViewController() -> UIViewController? {
        guard var topViewController =  UIApplication.shared.keyWindow?.rootViewController else {
            print("topview : nil")
            return nil
        }
        while topViewController.presentedViewController != nil {
            topViewController = topViewController.presentedViewController!
        }
        return topViewController
    }
    internal func presentAlert(title: String?, message: String?) {
        self.alertController.title = title
        self.alertController.message = message
        self.alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        guard let topViewController = self.getTopViewController() else {
            return
        }
        topViewController.present(alertController, animated: true, completion: nil)
    }
    
    internal func dismissAlert() {
        self.alertController.dismiss(animated: true, completion: nil)
    }
}
