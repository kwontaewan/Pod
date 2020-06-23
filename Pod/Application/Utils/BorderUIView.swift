//
//  BorderUIView.swift
//  Pod
//
//  Created by Gunter on 2020/06/23.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

@IBDesignable
class BorderUIView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable open var roundedView: Bool {
        
        get {
            return true
        }
        
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
            }
        }
        
    }
    
}
