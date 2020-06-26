//
//  UIViewController+StatusBar.swift
//  Pod
//
//  Created by Gunter on 2020/06/26.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

extension UITabBarController {
    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController?.childForStatusBarStyle ?? selectedViewController
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
}
