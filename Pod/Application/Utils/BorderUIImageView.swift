//
//  BorderUIImageView.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

@IBDesignable
class BorderUIImageView: UIImageView {
    
    @IBInspectable open var roundedImageView: Bool {
        
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
    
}
