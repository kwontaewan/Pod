//
//  UITableView.swift
//  Pod
//
//  Created by Gunter on 2020/07/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

extension UITableView {

    func setEmptyView(image: UIImage) {

        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let imageView = UIImageView()
        let messageLabel = UILabel()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyView.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        imageView.image = image
 
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restoreCell() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
    
}

