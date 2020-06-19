//
//  FirestoreUseCase.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxSwift
import FirebaseFirestore

protocol FirestoreUseCaseProtocol {
    
    func fetchTags() -> Observable<[Tag]>
    
    func fetchNewsList(tag: String) -> Observable<[News]>
    
}

final class FirestoreUsecase: FirestoreUseCaseProtocol {
    
    private let firestoreRepository: FirestoreRepository
    
    init(firestoreRepository: FirestoreRepository) {
        self.firestoreRepository = firestoreRepository
    }
    
    func fetchTags() -> Observable<[Tag]> {
        return firestoreRepository.fetchTags()
            .map { (snapshot) -> [Tag] in
                let dictionaries = snapshot.documents.compactMap { $0.data() }
                let tags = dictionaries.compactMap { TagResponseDTO(dic: $0).toDomain() }
                return tags
            }
    }
    
    func fetchNewsList(tag: String) -> Observable<[News]> {
        return firestoreRepository.fetchNewsList(tag: tag)
            .map { (snapshot) -> [News] in
                let dictionaries = snapshot.documents.compactMap { $0 }
                let news = dictionaries.compactMap { NewsResponseDTO(documentID: $0.documentID, dic: $0.data()).toDomain() }
                return news
            }
    }
    
}
