//
//  UILabel+Ext.swift
//  Pod
//
//  Created by Gunter on 2020/06/26.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

extension UIDevice {
    
    static var isiPadMini: Bool {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPad2,5", "iPad2,6", "iPad2,7",
             "iPad4,4", "iPad4,5", "iPad4,6",
             "iPad4,7", "iPad4,8", "iPad4,9",
             "iPad5,1", "iPad5,2":
            return true
        default: return false
        }
    }
    
    enum DeviceType {
        case iPhone_4, iPhone_5, iPhone_6, iPhone_6plus, iPhone_X, iPhone_XR, iPhone_MAX
        case iPad, iPad_Mini, iPad_Pro
    }
    
    static func isTargetDevice(target: DeviceType) -> Bool {
           let screenHeight = UIScreen.main.bounds.height
           switch screenHeight {
           case 480: return .iPhone_4 == target
           case 568: return .iPhone_5 == target
           case 667: return .iPhone_6 == target
           case 736: return .iPhone_6plus == target
           case 812: return .iPhone_X == target
           case 896: return .iPhone_XR == target || .iPhone_MAX == target
           case 1024: return UIDevice.isiPadMini ? .iPad_Mini == target : .iPad == target
           case 1366: return .iPad_Pro == target
           default: return false
           }
    }
    
}


extension UILabel {
    
    enum DeviceType {
        case iPhone_4, iPhone_5, iPhone_6, iPhone_6plus, iPhone_X, iPhone_XR, iPhone_MAX
        case iPad, iPad_Mini, iPad_Pro
    }
    
    func isTargetDevice(target: DeviceType) -> Bool {
        let screenHeight = UIScreen.main.bounds.height
        switch screenHeight {
        case 480: return .iPhone_4 == target
        case 568: return .iPhone_5 == target
        case 667: return .iPhone_6 == target
        case 736: return .iPhone_6plus == target
        case 812: return .iPhone_X == target
        case 896: return .iPhone_XR == target || .iPhone_MAX == target
        case 1024: return UIDevice.isiPadMini ? .iPad_Mini == target : .iPad == target
        case 1366: return .iPad_Pro == target
        default: return false
        }
    }
    
    func updateFontSize(target: DeviceType, fontSize: CGFloat) {
        guard isTargetDevice(target: target) && 0 < fontSize else {
            return
        }
        self.font = self.font.withSize(fontSize)
    }
    
    @IBInspectable var font_4s: CGFloat {
        get { fatalError("Only available in Interface Builder.") }
        set { updateFontSize(target: .iPhone_4, fontSize: newValue) }
    }
    
    @IBInspectable var font_5s: CGFloat {
        get { fatalError("Only available in Interface Builder.") }
        set { updateFontSize(target: .iPhone_5, fontSize: newValue) }
    }
    
}
