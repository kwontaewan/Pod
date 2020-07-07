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
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppAppearance.setupAppearance()
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
                
        if !UserDefaultsManagement.getSkipIntro() {
            UserDefaultsManagement.setNotification(true)
            UserDefaultsManagement.setEventNotification(true)
        }
                
        if UserDefaultsManagement.getNotification() || UserDefaultsManagement.getEventNotification() || !(UserDefaultsManagement.getSkipIntro()) {
            application.registerForRemoteNotifications()
        } else {
            application.unregisterForRemoteNotifications()
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainNavigaitonController = UINavigationController()
        
        let bookmarkNavigaitonController = UINavigationController()
        
        let settingNavigationController = UINavigationController()
        
        mainNavigaitonController.tabBarItem = UITabBarItem(
            title: "",
            image: Image.tabHomeOff,
            selectedImage: Image.tabHomeOn
        )
        
        bookmarkNavigaitonController.tabBarItem = UITabBarItem(
            title: "",
            image: Image.tabBookmarkOff,
            selectedImage: Image.tabBookmarkOn
        )
        
        settingNavigationController.tabBarItem = UITabBarItem(
            title: "",
            image: Image.tabSettingOff,
            selectedImage: Image.tabSettingOn
        )
        
        appFlowCoordinator = AppFlowCoordinator(
            mainNavigationController: mainNavigaitonController,
            bookmarkNavigationController: bookmarkNavigaitonController,
            settingNavigationController: settingNavigationController,
            appDIContainer: appDIContainer
        )
        
        let tabarController = UITabBarController()
        
        if #available(iOS 13.0, *) {
            let appearance = tabarController.tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundColor = .white
            tabarController.tabBar.standardAppearance = appearance
        } else {
            tabarController.tabBar.barTintColor = .white
            tabarController.tabBar.shadowImage = UIImage()
            tabarController.tabBar.backgroundImage = UIImage()
        }
                
        tabarController.viewControllers = [
            mainNavigaitonController,
            bookmarkNavigaitonController,
            settingNavigationController
        ]
        
        window?.rootViewController = tabarController
        
        appFlowCoordinator?.startMain()
        appFlowCoordinator?.startBookmark()
        appFlowCoordinator?.startSetting()
        window?.makeKeyAndVisible()
        
        Auth.auth().signInAnonymously() { (authResult, _) in
            guard let user = authResult?.user else { return }
            _ = user.isAnonymous  // true
            let uid = user.uid
            UserDefaultsManagement.setUserAuth(auth: uid)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
      print("[Log] deviceToken :", deviceTokenString)
        
      Messaging.messaging().apnsToken = deviceToken
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        log.debug()
        completionHandler([.alert, .badge, .sound])
    }
  
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        log.debug()
        completionHandler()
    }
  
}

extension AppDelegate: MessagingDelegate {
  
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        log.debug(fcmToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        log.debug(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        log.debug(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }
  
}
