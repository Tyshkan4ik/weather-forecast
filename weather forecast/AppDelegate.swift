//
//  AppDelegate.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 24.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        UIFont.familyNames.forEach({ name in
//            for font_name in UIFont.fontNames(forFamilyName: name) {
//                print("\n\(font_name)")
//            }
//        })
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            // Sets background to a blank/empty image
           // UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            // Sets shadow (line below the bar) to a blank image
            //UINavigationBar.appearance().shadowImage = UIImage()
            // Sets the translucent background color
            //UINavigationBar.appearance().backgroundColor = .clear
            // Set translucent. (Default value is already true, so this can be removed if desired.)
            //UINavigationBar.appearance().isTranslucent = false
            
            
            return true
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
