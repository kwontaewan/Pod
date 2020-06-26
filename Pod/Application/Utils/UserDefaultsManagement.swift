//
//  UserDefaultsManagement.swift
//  Pod
//
//  Created by Gunter on 2020/06/26.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

class UserDefaultsManagement {
    
    private static let SKIP_INTRO = "SKIP_INTRO"
    
    class func setSkipIntro() {
        UserDefaults.standard.set(true, forKey: SKIP_INTRO)
    }
    
    class func getSkipIntro() -> Bool {
        return UserDefaults.standard.bool(forKey: SKIP_INTRO)
    }
    
}
