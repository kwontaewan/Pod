//
//  MainNewsListViewModel.swift
//  Pod
//
//  Created by Gunter on 2020/06/23.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct MainNewsListViewModel {
    
    let title: String
    
    let description: String
          
    let imageUrl: String
          
    let link: String
    
    let registerAgo: String
    
    let tag: String
    
    let news: News
    
    init(with news: News) {
        self.title = news.title
        self.description = news.description
        self.imageUrl = news.imageUrl
        self.link = news.link
        self.registerAgo = news.pubDate
        self.tag = news.tags[0]
        self.news = news
    }
    
}
