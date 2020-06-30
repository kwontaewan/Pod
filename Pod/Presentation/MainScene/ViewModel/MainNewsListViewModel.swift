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
        self.description = news.contents
        self.imageUrl = news.imageUrl
        self.link = news.originLink
        self.registerAgo = Utility.SecondTimeConvert(
            sec: (Date().millisecondsSince1970 - Utility.miliSecFromDate(date: news.registerDateTime)) / 1000 
        )
        self.tag = news.tags[0]
        self.news = news
    }
    
}
