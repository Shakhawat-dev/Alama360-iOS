//
//  AppDelegate.swift
//  Alama360
//
//  Created by Alama360 on 10/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let defaults = UserDefaults.standard
    var userLoggedIn: Bool?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        UITabBar.appearance().barTintColor = .
        // Google Map Api for MapView
//        LanguageManager.shared.defaultLanguage = .ar
        print("here app delegate ")
        LanguageManager.shared.defaultLanguage = .deviceLanguage
        
        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
        userLoggedIn = defaults.bool(forKey: "loggedIn")
        
//        LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
        
//        LanguageManager.shared.currentLanguage = .ar
//        LanguageManager.shared.setLanguage(language: .ar)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // For Dark Mode
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
//        Self.shared = self
        Switcher.updateRootVC()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

