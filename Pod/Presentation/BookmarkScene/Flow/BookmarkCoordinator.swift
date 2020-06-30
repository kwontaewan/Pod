//
//  BookmarkCoordinator.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

protocol BookmarkCoordinatorDependencies {
    
    func makeBookmarkViewController(
        coordinator: BookmarkCoordinator
    ) -> BookmarkViewController
    
}

protocol BookmarkCoordinator {
    
    func start()
    
}

class DefaultBookmarkFlowCoordinator: DetectDeinit, BookmarkCoordinator {
    
    private let navigationController: UINavigationController
        
    private let dependencies: BookmarkCoordinatorDependencies
    
    init(
        navigationController: UINavigationController,
        dependencies: BookmarkCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeBookmarkViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
