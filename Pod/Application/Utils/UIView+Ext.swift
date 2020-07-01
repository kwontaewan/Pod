//
//  UIView+Ext.swift
//  Pod
//
//  Created by Gunter on 2020/06/23.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

extension UIView {
    
    static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> T where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
    
    class var insetSafeAreaBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets.bottom ?? 0
        }
        else {
            return 0
        }
    }
    
}
