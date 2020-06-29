//
//  AppDIContainer.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

final class AppDIContainer {
    
    func makeMainSceneDIContainer() -> MainSceneDIContainer {
        return MainSceneDIContainer()
    }
    
    func makeNewsDetailSceneDIContainer() -> NewsDetailSceneDIContainer {
        return NewsDetailSceneDIContainer()
    }
    
    func makeBookmarkSceneDIContainer() -> BookmarkSceneDIContainer {
        return BookmarkSceneDIContainer()
    }
    
}
