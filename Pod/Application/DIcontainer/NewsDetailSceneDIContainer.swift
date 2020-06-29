//
//  NewsDetailSceneDIContainer.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import FirebaseFirestore

final class NewsDetailSceneDIContainer {
    
    // MARK: - Use Cases
    func makeFirestoreUseCase() -> FirestoreUseCaseProtocol {
        return FirestoreUsecase(firestoreRepository: makeFirestoreRepository())
    }
    
    func makeRealmUseCase() -> RealmUseCaseProtocol {
         return RealmUseCase(repository: makeRealmRepository())
     }
    
    // MARK: - Repositories
    func makeFirestoreRepository() -> FirestoreRepository {
        return FirestoreDAO(db: Firestore.firestore())
    }
    
    func makeRealmRepository() -> RealmDAO<News> {
        let repository = RealmDAO<News>(configuration: Realm.Configuration())
        return repository
    }
    
    // MARK: - NewsDetail
    func makeNewsDetailViewController(news: News) -> NewsDetailViewController {
        return NewsDetailViewController.create(with: makeNewsDetailViewModel(news: news))
    }
    
    func makeNewsDetailViewModel(
        news: News
    ) -> NewsDetailViewModel {
        return NewsDetailViewModel(
            news: news,
            realmUseCases: makeRealmUseCase(),
            firestoreUseCases: makeFirestoreUseCase())
    }
    
    // MARK: - Flow Coordinators
    func makeNewDetailCoordinator(
        navigationController: UINavigationController?
    ) -> NewsDetailFlowCoordinator {
        return DefaultNewsDetailFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
}

extension NewsDetailSceneDIContainer: NewsDetailCoordinatorDependencies { }
