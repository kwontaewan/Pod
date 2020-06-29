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
    
    private static let USER_AUTH = "USER_AUTH"
    
    class func setSkipIntro() {
        UserDefaults.standard.set(true, forKey: SKIP_INTRO)
    }
    
    class func getSkipIntro() -> Bool {
        return UserDefaults.standard.bool(forKey: SKIP_INTRO)
    }
    
    class func setUserAuth(auth: String) {
        return UserDefaults.standard.set(auth, forKey: USER_AUTH)
    }
    
    class func getUserAuth() -> String {
        return UserDefaults.standard.string(forKey: USER_AUTH) ?? ""
    }
    
}
