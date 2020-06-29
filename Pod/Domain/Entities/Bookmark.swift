//
//  Bookmark.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RealmSwift

class Bookmark: Object {
    
    @objc dynamic var documentID: String = ""
      
    @objc dynamic var title: String = ""
      
    @objc dynamic var contents: String = ""
         
    @objc dynamic var imageUrl: String = ""
         
    @objc dynamic var link: String = ""
      
    @objc dynamic var originLink: String = ""
         
    @objc dynamic var pubDate: String = ""
      
    @objc dynamic var registerDateTime: String = ""
             
    @objc dynamic var tags: [String] = []
    
    @objc dynamic var time: TimeInterval = Date().timeIntervalSinceReferenceDate

}

extension Bookmark: DomainConvertibleType {
        
    func toDomain() -> News {
        return .init(
            documentID: documentID,
            title: title,
            contents: contents,
            imageUrl: imageUrl,
            link: link,
            originLink: originLink,
            pubDate: pubDate,
            registerDateTime: registerDateTime,
            tags: tags
        )
    }
    
}

extension Bookmark: RealmRepresentable {
    
    func asRealm() -> Bookmark {
        return Bookmark.build { (object) in
            object.documentID = documentID
            object.title = title
            object.contents = contents
            object.imageUrl = imageUrl
            object.link = link
            object.originLink = originLink
            object.pubDate = pubDate
            object.registerDateTime = registerDateTime
            object.tags = tags
        }
    }

}
