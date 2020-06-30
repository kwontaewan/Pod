//
//  SettingCoordinator.swift
//  Pod
//
//  Created by Gunter on 2020/06/30.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

protocol SettingCoordinatorDependencies {
    
    func makeSettingViewController() -> SettingViewController
    
}

protocol SettingCoordinator {
    
    func start()
    
}

class DefaultSettingCoordinator: DetectDeinit, SettingCoordinator {
    
    private let navigationController: UINavigationController
        
    private let dependencies: SettingCoordinatorDependencies
    
    init(
        navigationController: UINavigationController,
        dependencies: SettingCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeSettingViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
}
