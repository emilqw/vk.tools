//
//  AppDelegate.swift
//  VK
//
//  Created by Эмиль Яйлаев on 13.10.2021.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func allUIControlState( completion:@escaping (UIControl.State)->()){
        completion(UIControl.State.normal)
        completion(UIControl.State.highlighted)
        completion(UIControl.State.disabled)
        completion(UIControl.State.focused)
        completion(UIControl.State.selected)
        completion(UIControl.State.application)
        completion(UIControl.State.reserved)
    }
    func setFont(_ size:CGFloat = 18) -> [NSAttributedString.Key:Any] {
        return [NSAttributedString.Key.font: UIFont(name: "VKSansDisplay-Medium", size: size)!]
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().titleTextAttributes = setFont(18)
        UINavigationBar.appearance().largeTitleTextAttributes = setFont(35)
        allUIControlState { key in
            UIBarButtonItem.appearance().setTitleTextAttributes(self.setFont(16), for: key)
            UIBarItem.appearance().setTitleTextAttributes(self.setFont(), for: key)
            UITabBarItem.appearance().setTitleTextAttributes(self.setFont(13), for: key)
        }
        return true
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

