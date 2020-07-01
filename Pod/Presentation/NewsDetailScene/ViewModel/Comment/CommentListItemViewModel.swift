//
//  CommnetListItemViewModel.swift
//  Pod
//
//  Created by Gunter on 2020/07/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct CommentListItemViewModel {
    
    let contents: String
    
    let registerAgo: String
    
    let comment: Comment
    
    init(with comment: Comment) {
        self.contents = comment.contents
        self.registerAgo = Utility.SecondTimeConvert(
            sec: (Date().millisecondsSince1970 - Utility.miliSecFromDate(date: comment.regDate)) / 1000
        )
        self.comment = comment
    }
    
    
}
