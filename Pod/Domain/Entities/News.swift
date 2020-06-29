//
//  News.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct News {
    
    let documentID: String
      
    let title: String
      
    let contents: String
         
    let imageUrl: String
         
    let link: String
      
    let originLink: String
         
    let pubDate: String
      
    let registerDateTime: String
             
    let tags: [String]
}

extension News: Equatable {
    public static func == (lhs: News, rhs: News) -> Bool {
            return lhs.documentID == rhs.documentID &&
                lhs.title == rhs.title &&
                lhs.contents == rhs.contents &&
                lhs.imageUrl == rhs.imageUrl &&
                lhs.link == rhs.link &&
                lhs.originLink == rhs.originLink &&
                lhs.pubDate == rhs.pubDate &&
                lhs.registerDateTime == rhs.registerDateTime &&
                lhs.tags == rhs.tags
    }
}
