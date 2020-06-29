//
//  AppDelegate.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppAppearance.setupAppearance()
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainNavigaitonController = UINavigationController()
        
        let bookmarkNavigaitonController = UINavigationController()
        
        mainNavigaitonController.tabBarItem = UITabBarItem(
            title: "Main",
            image: nil,
            selectedImage: nil
        )
        
        bookmarkNavigaitonController.tabBarItem = UITabBarItem(
            title: "Bookmark",
            image: nil,
            selectedImage: nil
        )
        
        appFlowCoordinator = AppFlowCoordinator(
            mainNavigationController: mainNavigaitonController,
            bookmarkNavigationController: bookmarkNavigaitonController,
            appDIContainer: appDIContainer
        )
        
        let tabarController = UITabBarController()
        
        tabarController.viewControllers = [
            mainNavigaitonController,
            bookmarkNavigaitonController
        ]
        
        window?.rootViewController = tabarController
        
        appFlowCoordinator?.startMain()
        appFlowCoordinator?.startBookmark()
        window?.makeKeyAndVisible()
        
        Auth.auth().signInAnonymously() { (authResult, _) in
            guard let user = authResult?.user else { return }
            _ = user.isAnonymous  // true
            let uid = user.uid
            log.info("uid \(uid)")
        }
        
        return true
    }
    
}
