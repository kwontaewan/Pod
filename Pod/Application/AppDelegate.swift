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

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = UIViewController()
        
        vc.view.backgroundColor = .white
        
        let mainNavigaitonController = UINavigationController(rootViewController: vc)
        
        mainNavigaitonController.tabBarItem = UITabBarItem(
            title: "Main",
            image: nil,
            selectedImage: nil
        )
        
        let tabarController = UITabBarController()
        
        tabarController.viewControllers = [
            mainNavigaitonController
        ]
        
        window?.rootViewController = tabarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
