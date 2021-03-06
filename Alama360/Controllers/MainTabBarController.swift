//
//  MainTabBarController.swift
//  Alama360
//
//  Created by Alama360 on 19/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        // Do any additional setup after loading the view.\
//        tabBarController?.tabBar.items![1].title = "xx"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        guard let items = tabBar.items else { return }
        
        items[0].image = #imageLiteral(resourceName: "icons8-search-100")
        items[1].image = #imageLiteral(resourceName: "icons8-event-100")
        items[2].image = #imageLiteral(resourceName: "icons8-heart-100")
        items[3].image = #imageLiteral(resourceName: "icons8-more-100")
        
    
        items[0].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search", comment: "").localiz()
        items[1].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "reservations", comment: "").localiz()
        items[2].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "favorites", comment: "").localiz()
        items[3].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "more", comment: "").localiz()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
