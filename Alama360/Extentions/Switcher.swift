//
//  Switcher.swift
//  Alama360
//
//  Created by Alama360 on 02/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation

import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: "loggedIn")
        var rootVC : UIViewController?
        
        print(status)

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vc") as! ViewController
        }
        let window = UIApplication.shared.windows.first
        //        let appDelegate = UIApplication.shared.delegate as! SceneDelegate
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
    }
    
}
