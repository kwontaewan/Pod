//
//  CommentCell.swift
//  Pod
//
//  Created by Gunter on 2020/07/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CommentCell.self)
    
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
