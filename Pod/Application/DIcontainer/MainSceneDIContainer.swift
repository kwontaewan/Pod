//
//  MainSceneDIContainer.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Firebase

final class MainSceneDIContainer {
    
    // MARK: - Use Cases
    func makeFirestoreUseCase() -> FirestoreUseCaseProtocol {
        return FirestoreUsecase(firestoreRepository: makeFirestoreRepository())
    }
    
    // MARK: - Repositories
    
    func makeFirestoreRepository() -> FirestoreRepository {
        return FirestoreDAO(db: Firestore.firestore())
    }
    // MARK: - Main
    func makeMainViewController(coordinator: MainFlowCoordinator) -> MainViewController {
        return MainViewController.create(with: makeMainViewModel(coordinator: coordinator))
    }
    
    func makeMainViewModel(coordinator: MainFlowCoordinator) -> MainViewModel {
        return MainViewModel(firestoreUseCases: makeFirestoreUseCase(), coordinator: coordinator)
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
