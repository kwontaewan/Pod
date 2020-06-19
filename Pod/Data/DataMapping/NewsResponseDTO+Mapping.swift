//
//  NewsResponseDTO+Mapping.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct NewsResponseDTO {
    
    let documentID: String
    
    let title: String
    
    let description: String
       
    let imageUrl: String
       
    let link: String
       
    let pubDate: String
       
    let tags: [String]
       
    init(documentID: String,
         dic: [String: Any]
    ) {
        self.documentID = documentID
        self.title = dic["title"] as? String ?? ""
        self.description = dic["description"] as? String ?? ""
        self.imageUrl = dic["imageUrl"] as? String ?? ""
        self.link = dic["link"] as? String ?? ""
        self.pubDate = dic["pubDate"] as? String ?? ""
        self.tags = dic["tags"] as? [String] ?? []
    }
    
}

extension NewsResponseDTO {
    
    func toDomain() -> News {
        return .init(
            documentID: documentID,
            title: title,
            description: description,
            imageUrl: imageUrl,
            link: link,
            pubDate: pubDate,
            tags: tags
        )
    }
    
}
