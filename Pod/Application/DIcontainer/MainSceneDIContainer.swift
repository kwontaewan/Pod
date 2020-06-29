//
//  MainSceneDIContainer.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import FirebaseFirestore

final class MainSceneDIContainer {
    
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
    
    // MARK: - Main
    func makeMainViewController(coordinator: MainFlowCoordinator) -> MainViewController {
        return MainViewController.create(with: makeMainViewModel(coordinator: coordinator))
    }
    
    func makeMainViewModel(coordinator: MainFlowCoordinator) -> MainViewModel {
        return MainViewModel(
            firestoreUseCases: makeFirestoreUseCase(),
            realmUseCases: makeRealmUseCase(),
            coordinator: coordinator
        )
    }
    
    func makeGestureIntroViewController() -> GestureIntroViewController {
        return GestureIntroViewController.create()
    }
    
    // MARK: - Flow Coordinators
    func makeMainFlowCoordinator(
        navigationController: UINavigationController
    ) -> MainFlowCoordinator {
        return DefaultMainFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
}

extension MainSceneDIContainer: MainFlowCoordinatorDependencies { }
