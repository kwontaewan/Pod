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
        coordinator: NewsDetailFlowCoordinator,
        news: News
    ) -> NewsDetailViewController
    
    func makeShowCommentViewController() -> CommentViewController
    
}

protocol NewsDetailFlowCoordinator {
    
    func start(news: News, viewType: ViewType?)
    
    func showCommentView()
    
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
        let vc = dependencies.makeNewsDetailViewController(coordinator: self, news: news)
        vc.viewType = viewType
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showCommentView() {
        let vc = dependencies.makeShowCommentViewController()
        navigationController?.visibleViewController?.presentPanModal(vc)
     }
    
}
