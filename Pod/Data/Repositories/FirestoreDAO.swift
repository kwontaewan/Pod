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
    
    func registerComment(
        documentId: String,
        authKey: String,
        contents: String
    ) -> Observable<Void> {
        return db.collection("feed")
            .document(documentId)
            .collection("comments")
            .document()
            .rx
            .setData(["authKey": authKey, "contents": contents, "regDate": getDateTime()])
    }
    
    func fetchComments(documentId: String) -> Observable<QuerySnapshot> {
        return db.collection("feed")
            .document(documentId)
            .collection("comments")
            .order(by: "regDate", descending: true)
            .rx
            .getDocuments()
    }
    
    func getDateTime() -> String {
          let now = Date()
          let date = DateFormatter()
          date.locale = Locale(identifier: "ko_kr")
          date.timeZone = TimeZone(abbreviation: "KST")
          date.dateFormat = "yyyy-MM-dd HH:mm:ss"
          return date.string(from: now)
      }
    
}
