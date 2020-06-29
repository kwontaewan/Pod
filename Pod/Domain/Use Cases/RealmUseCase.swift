//
//  RealmUseCase.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxSwift

protocol RealmUseCaseProtocol {

    func saveBookmark(news: News) -> Observable<Void>
    
    func fetchBookmark() -> Observable<[News]>
    
}

final class RealmUseCase<RealmDAO>: RealmUseCaseProtocol where RealmDAO: RealmRepository, RealmDAO.T == News {
    
    private let realmRepositroy: RealmDAO
    
    init(repository: RealmDAO) {
        self.realmRepositroy = repository
    }
    
    func saveBookmark(news: News) -> Observable<Void> {
        return realmRepositroy.save(entity: news)
    }
    
    func fetchBookmark() -> Observable<[News]> {
        return realmRepositroy.queryAll()
    }
    
}
