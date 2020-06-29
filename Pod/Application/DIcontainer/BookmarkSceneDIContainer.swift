//
//  BookmarkSceneDIContainer.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

final class BookmarkSceneDIContainer {
    
    // MARK: - Use Cases
    func makeRealmUseCase() -> RealmUseCaseProtocol {
        return RealmUseCase(repository: makeRealmRepository())
    }
    
     // MARK: - Repositories
    func makeRealmRepository() -> RealmDAO<News> {
        let repository = RealmDAO<News>(configuration: Realm.Configuration())
        return repository
    }
    
    // MARK: - Bookmark
    func makeBookmarkViewController(coordinator: BookmarkCoordinator) -> BookmarkViewController {
        return BookmarkViewController.create(with: makeBookmarkViewModel(coordinator: coordinator))
    }
    
    func makeBookmarkViewModel(coordinator: BookmarkCoordinator) -> BookmarkViewModel {
        return BookmarkViewModel(
            realmUseCases: makeRealmUseCase(),
            coordinator: coordinator
        )
    }
    
    // MARK: - Flow Coordinators
    func makeBookmarkFlowCoordinator(
        navigationController: UINavigationController
    ) -> BookmarkCoordinator {
        return DefaultBookmarkFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

extension BookmarkSceneDIContainer: BookmarkCoordinatorDependencies { }
