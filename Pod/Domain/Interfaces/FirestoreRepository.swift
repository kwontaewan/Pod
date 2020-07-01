//
//  FireStoreRepository.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxSwift
import FirebaseFirestore

protocol FirestoreRepository {
    
    func fetchTags() -> Observable<QuerySnapshot>
    
    func fetchNewsList(tag: String) -> Observable<QuerySnapshot>

    func registerComment(
        documentId: String,
        authKey: String,
        contents: String
    ) -> Observable<Void>
    
    func fetchComments(documentId: String) -> Observable<QuerySnapshot>
    
}
