//
//  CommentResponseDTO+Mapping.swift
//  Pod
//
//  Created by Gunter on 2020/07/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct CommentResponseDTO {
    
    let authKey: String
    
    let contents: String
    
    let regDate: String
    
    init(dic: [String: Any]) {
        self.authKey = dic["authKey"] as? String ?? ""
        self.contents = dic["contents"] as? String ?? ""
        self.regDate = dic["regDate"] as? String ?? ""
    }
    
}

extension CommentResponseDTO {
    
    func toDomain() -> Comment {
        return .init(
            authKey: authKey,
            contents: contents,
            regDate: regDate
        )
    }
    
}
