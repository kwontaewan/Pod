//
//  BookmarkCell.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

class BookmarkCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: BookmarkCell.self)

    @IBOutlet weak var newsImageView: BorderUIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var linkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
