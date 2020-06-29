//
//  BookmarkListItemViewModel.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct BookmarkListItemViewModel {
    
    let imageUrl: String
    
    let title: String
    
    let link: String
    
    let news: News
    
    init(with news: News) {
        self.imageUrl = news.imageUrl
        self.title = news.title
        self.link = news.originLink
        self.news = news
    }
    
}
