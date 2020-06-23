//
//  TagCell.swift
//  Pod
//
//  Created by Gunter on 2020/06/23.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: TagCell.self)
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            toggleSelectedState()
        }
    }
    
    func toggleSelectedState() {
        if isSelected {
            tagLabel.textColor = UIColor.reddishOrange
        } else {
            tagLabel.textColor = UIColor.lightBlack
        }
    }
    
}
