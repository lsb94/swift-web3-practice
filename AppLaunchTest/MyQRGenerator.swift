//
//  MyQRGenerator.swift
//  AppLaunchTest
//
//  Created by sungbin on 2020/03/17.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

class MyQRGenerator {
    static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
