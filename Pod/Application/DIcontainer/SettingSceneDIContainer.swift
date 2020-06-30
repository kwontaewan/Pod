//
//  SettingSceneDIContainer.swift
//  Pod
//
//  Created by Gunter on 2020/06/30.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

final class SettingSceneDIContainer {
    
    // MARK: - Setting
    func makeSettingViewController() -> SettingViewController {
        return SettingViewController.create()
    }
    
    // MARK: - Flow Coordinators
    func makeSettingFlowCoordinator(
        navigationController: UINavigationController
    ) -> SettingCoordinator {
        return DefaultSettingCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
}

extension SettingSceneDIContainer: SettingCoordinatorDependencies { }
