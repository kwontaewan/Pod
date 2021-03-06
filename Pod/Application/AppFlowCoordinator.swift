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
    var bookmarkNavigationController: UINavigationController
    var settingNavigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        mainNavigationController: UINavigationController,
        bookmarkNavigationController: UINavigationController,
        settingNavigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.mainNavigationController = mainNavigationController
        self.bookmarkNavigationController = bookmarkNavigationController
        self.settingNavigationController = settingNavigationController
        self.appDIContainer = appDIContainer
    }
    
    func startMain() {
        let mainSceneDIContainer = appDIContainer.makeMainSceneDIContainer()
        let flow = mainSceneDIContainer.makeMainFlowCoordinator(navigationController: mainNavigationController)
        flow.start()
    }
    
    func startNewsDetail(
        news: News,
        viewType: ViewType,
        navigationViewController: UINavigationController?
    ) {
        let newDetailSceneDIContainer = appDIContainer.makeNewsDetailSceneDIContainer()
        let flow = newDetailSceneDIContainer.makeNewDetailCoordinator(navigationController: navigationViewController)
        flow.start(news: news, viewType: viewType)
    }
    
    func startBookmark() {
        let bookmarkSceneDIContainer = appDIContainer.makeBookmarkSceneDIContainer()
        let flow = bookmarkSceneDIContainer.makeBookmarkFlowCoordinator(navigationController: bookmarkNavigationController)
        flow.start()
    }
    
    func startSetting() {
        let settingSceneDIContainer = appDIContainer.makeSettingSceneDIContainer()
        let flow = settingSceneDIContainer.makeSettingFlowCoordinator(navigationController: settingNavigationController)
        flow.start()
    }

}
