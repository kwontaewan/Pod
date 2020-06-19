//
//  TagResponseDTO+Mapping.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

struct TagResponseDTO: ModelType {
    
    let name: String
    
    init(dic: [String: Any]) {
        self.name = dic["name"] as? String ?? ""
    }
    
}

extension TagResponseDTO {

    func toDomain() -> Tag {
        return .init(name: name)
    }
    
}
