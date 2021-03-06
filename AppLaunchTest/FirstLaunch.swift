//
//  FirstLaunch.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/02/17.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation

final class FirstLaunch {
    let userDefaults: UserDefaults = .standard
    let wasLaunchedBefore: Bool
    var isFirstLaunch: Bool { return !wasLaunchedBefore }
    init() {
        let key = "isFirstLaunch"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore { userDefaults.set(true, forKey: key) }
        
    }
    
}

