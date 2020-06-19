//
//  AppDelegate.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Firebase

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
        
        mainNavigaitonController.tabBarItem = UITabBarItem(
            title: "Main",
            image: nil,
            selectedImage: nil
        )
        
        appFlowCoordinator = AppFlowCoordinator(
            mainNavigationController: mainNavigaitonController,
            appDIContainer: appDIContainer
        )
        
        let tabarController = UITabBarController()
        
        tabarController.viewControllers = [
            mainNavigaitonController
        ]
        
        window?.rootViewController = tabarController
        
        appFlowCoordinator?.startMain()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
