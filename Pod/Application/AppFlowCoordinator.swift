//
//  AppFlowCoordinator.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

class AppFlowCoordinator {
    
    var mainNavigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        mainNavigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.mainNavigationController = mainNavigationController
        self.appDIContainer = appDIContainer
    }
    
    func startMain() {
        let mainSceneDIContainer = appDIContainer.makeMainSceneDIContainer()
        let flow = mainSceneDIContainer.makeMainFlowCoordinator(navigationController: mainNavigationController)
        flow.start()
    }
    
}
