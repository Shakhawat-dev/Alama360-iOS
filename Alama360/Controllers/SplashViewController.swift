//
//  SplashViewController.swift
//  Alama360
//
//  Created by Alama360 on 02/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    let defaults = UserDefaults.standard
    var lan: String = ""
    var userId: String = ""
    var phone: String = ""
    var status: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        
        status = defaults.bool(forKey: "loggedIn")
//        print(status)
//        Switcher.updateRootVC()
        
        if (status!) {
            
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let centerVC = mainStoryBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            
            // setting the login status to true
//            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
//            UserDefaults.standard.synchronize()
            appDel.window!.rootViewController = centerVC
            appDel.window!.makeKeyAndVisible()
        }
        
        // Do any additional setup after loading the view.
    }
    

}
