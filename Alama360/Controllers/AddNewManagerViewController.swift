//
//  AddNewManagerViewController.swift
//  Alama360
//
//  Created by Alama360 on 08/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import iOSDropDown
import LanguageManager_iOS
import Alamofire
import SwiftyJSON

class AddNewManagerViewController: UIViewController {
    
    @IBOutlet weak var lblmanagerHeaderTitle: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var _FirstNameField: UITextField!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var _lastNameField: UITextField!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var _mobileField: UITextField!
    @IBOutlet weak var managerStatusDropDown: DropDown!
    @IBOutlet weak var btnSave: CustomBtnGreen!
    
    //For storing user data
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    var userId: String = ""
    var managerStatus: Int = 0
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For Hiding keyboard on Tap
        self.hideKeyboardWhenTappedAround()
        // Getting User Details
        userId = defaults.string(forKey: "userID")!
        
        managerStatusDropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index) \n id: \(id)")
            self.managerStatus = id
        }
        // Do any additional setup after loading the view.
        setViews()
    }
    
    func setViews() {
        managerStatusDropDown.optionArray = ["Active", "Inactive"]
        managerStatusDropDown.optionIds = [1, 0]
    }
    
    //    lang=en&property_title=""&slug=""&property_id=130&userid=257&author_id=257&manager_firstname=Shaheen&manager_lastname=shakhawat&manager_mobile=966533858538&manager_sms_status=1
    
    func addNewManager() {
     
        let params : [String : String] = ["lang" : "en",
                                          "property_title" : "",
                                          "slug" : "",
                                          "property_id" : id,
                                          "userid" : userId,
                                          "author_id" : userId,
                                          "manager_firstname" : _FirstNameField.text ?? "",
                                          "manager_lastname" : _lastNameField.text ?? "",
                                          "manager_mobile" : _mobileField.text ?? "",
                                          "manager_sms_status" : String(managerStatus)]
        
        print(params)
        
        let mUrl = "\(StaticUrls.BASE_URL_FINAL)addclientmanager?"
        
        Alamofire.request(mUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                print(mysresponse)
  
            }
        }
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        addNewManager()
    }
}
