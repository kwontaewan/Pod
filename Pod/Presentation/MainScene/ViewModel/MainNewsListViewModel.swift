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
        self.link = news.originLink
        self.registerAgo = news.registerDateTime
        self.tag = news.tags[0]
        self.news = news
    }
    
}

public enum Times {
    case sec
    
    case min
    
    case hour
    
    case day
    
    case month
    
    var value: Int {
        switch self {
        case .sec:
            return 60
        case .min:
            return 60 * 60
        case .hour:
            return 24 * 60 * 60
        case .day:
            return 30 * 24 * 60 * 60
        case .month:
            return 12 * 30 * 24 * 60 * 60
        }
    }
}

public enum SecondToTime {
    
    case sec(second: Int)
    
    case min(second: Int)
    
    case hour(second: Int)
    
    case day(second: Int)
    
    case month(second: Int)
    
    case year(second: Int)
    
    var time: String {
        switch self {
        case .sec(let second):
            return "\(second)\("second".localized)"
        case .min(let second):
            let time = second / Times.sec.value
            return "\(time)\("minute".localized)"
        case .hour(let second):
            let time = second / Times.min.value
            return "\(time)\("hour".localized)"
        case .day(let second):
            let time = second / Times.hour.value
            return "\(time)\("day".localized)"
        case .month(let second):
            let time = second / Times.day.value
            return "\(time)\("month".localized)"
        case .year(let second):
            let time = second / Times.month.value
            return "\(time)\("yaer".localized)"
        }
    }
    
}
