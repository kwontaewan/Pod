//
//  FirestoreDAO.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxFirebase
import FirebaseFirestore
import RxSwift

final class FirestoreDAO: DetectDeinit, FirestoreRepository {
    
    private let db: Firestore
    
    init(db: Firestore) {
        self.db = db
    }
    
    func fetchTags() -> Observable<QuerySnapshot> {
        return db.collection("tags")
            .rx
            .getDocuments()
    }
    
    func fetchNewsList(tag: String) -> Observable<QuerySnapshot> {
        return db.collection("feed")
            .whereField("tags", arrayContains: tag)
            .rx
            .getDocuments()
    }
    
}
