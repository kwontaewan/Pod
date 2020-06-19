//
//  MainFlowCoordinator.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

protocol MainFlowCoordinatorDependencies {
    
    func makeMainViewController(
        coordinator: MainFlowCoordinator
    ) -> MainViewController
    
}

protocol MainFlowCoordinator {
    
    func start()
    
    func presentGuideView()
    
}

class DefaultMainFlowCoordinator: DetectDeinit, MainFlowCoordinator {
    
    private let navigationController: UINavigationController
    
    private let dependencies: MainFlowCoordinatorDependencies
    
    init(
        navigationController: UINavigationController,
        dependencies: MainFlowCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeMainViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentGuideView() {
        
    }
    
}
