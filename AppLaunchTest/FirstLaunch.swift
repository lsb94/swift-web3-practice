//
//  FirstLaunch.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/17.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation

final class FirstLaunch {
    var wasLaunchedBefore: Bool
    var isFirstLaunch: Bool { return !wasLaunchedBefore }
    init() {
        guard let isThereAddress = UserDefaults.standard.string(forKey: "address") else {
            self.wasLaunchedBefore = false
            return
        }
        self.wasLaunchedBefore = true
    }
    
}

