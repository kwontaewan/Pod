//
//  ToastView.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import SnapKit

class ToastView: UIView {
    
    let view: UIView = UIView()
    
    let label: UILabel = UILabel()
    
    let closeImageView = UIImageView()
    
    func inner(to: UIView) {
        to.addSubview(self)
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(48)
        }
        
        self.addSubview(view)
        self.view.layer.cornerRadius = 4
        self.view.backgroundColor = .clear
        self.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.alpha = 0.0
        self.label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.label.textColor = .white
        
        self.closeImageView.image = Image.whithCloseIcon
        
        self.view.addSubview(label)
        self.view.addSubview(closeImageView)
        
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        closeImageView.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(3)
            make.right.equalToSuperview().offset(-3)
            make.centerY.equalToSuperview()
        }
        
        closeImageView.isUserInteractionEnabled = true
        
        closeImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(close))
        )
        
    }
    
    @objc func close() {
        hideToast()
    }
    
    func showToast(title: String) {
        
        label.text = title
        
        UIView.animate(withDuration: 0.5,
            delay: 0.0,
            options: [.allowUserInteraction, .curveEaseInOut ],
            animations: { self.alpha = 1.0 },
            completion: nil)
        
        UIView.animate(withDuration: 0.5,
            delay: 0.5,
            options: [.allowUserInteraction, .curveEaseInOut ],
            animations: { self.alpha = 0.0 },
            completion: nil)
        
    }
    
    func hideToast() {
        UIView.animate(withDuration: 0.5,
            delay: 0.5,
            options: [.allowUserInteraction, .curveEaseInOut ],
            animations: { self.alpha = 0.0 },
            completion: nil)
    }
        
}
