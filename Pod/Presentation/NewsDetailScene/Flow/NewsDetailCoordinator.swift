//
//  NewsDetailCoordinator.swift
//  Pod
//
//  Created by Gunter on 2020/06/26.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

protocol NewsDetailCoordinatorDependencies {
    
    func makeNewsDetailViewController(
        news: News
    ) -> NewsDetailViewController
    
}

protocol NewsDetailFlowCoordinator {
    
    func start(news: News, viewType: ViewType?)
    
}

class DefaultNewsDetailFlowCoordinator: DetectDeinit, NewsDetailFlowCoordinator {
        
    private let navigationController: UINavigationController?
    
    private let dependencies: NewsDetailCoordinatorDependencies
    
    init(
        navigationController: UINavigationController?,
        dependencies: NewsDetailCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start(news: News, viewType: ViewType?) {
        let vc = dependencies.makeNewsDetailViewController(news: news)
        vc.viewType = viewType
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
