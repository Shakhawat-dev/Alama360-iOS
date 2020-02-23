//
//  PropertySettingsViewController.swift
//  Alama360
//
//  Created by Alama360 on 28/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import LanguageManager_iOS

class PropertySettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    
    var bankArray = [BankCategoryModel]()
    var clientManagerArray = [ClientManagerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        // Do any additional setup after loading the view.
        loadClientManager()
        loadBankCateory()
    }
    
    func loadClientManager() {
        let nUrl = StaticUrls.BASE_URL_FINAL + "getclientmanager?lang=en&property_title=&slug=&property_id=130&userid=257&author_id=257"
        
        Alamofire.request(nUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                //                print(resultArray)
                for i in resultArray.arrayValue {
                    let manager = ClientManagerModel(json: i)
                    self.clientManagerArray.append(manager)
                }
                
                
            }
        }
    }
    
    func loadBankCateory() {
        
    }
    
}
