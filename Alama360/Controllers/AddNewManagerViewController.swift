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
    var manager_id: String = ""
    
    var manager_firstname: String = ""
    var manager_lastname: String = ""
    var manager_mobile: String = ""
    var manager_sms_status: String = ""
    
    var segueValues: (prop_id: String, manager_id: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For Hiding keyboard on Tap
        self.hideKeyboardWhenTappedAround()
        // Getting User Details
        userId = defaults.string(forKey: "userID")!
        
        id = segueValues?.prop_id ?? "0"
        manager_id = segueValues?.manager_id ?? "0"
        
        managerStatusDropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index) \n id: \(id)")
            self.managerStatus = id
        }
        // Do any additional setup after loading the view.
        setViews()
        
        if !(manager_id == "0") {
            loadManager()
        }
    }
    
    func setViews() {
        managerStatusDropDown.optionArray = ["Active", "Inactive"]
        managerStatusDropDown.optionIds = [1, 2]
    }
    
    //    lang=en&property_title=""&slug=""&property_id=130&userid=257&author_id=257&manager_firstname=Shaheen&manager_lastname=shakhawat&manager_mobile=966533858538&manager_sms_status=1
    
    func loadManager() {
        let tUrl = StaticUrls.BASE_URL_FINAL + "getsingleclientmanager?lang=en&dataview=select&property_title=&slug=&property_id=\(id)&userid=\(userId)&author_id=\(userId)&managerid=\(manager_id)"
        
                print(tUrl)
        
                Alamofire.request(tUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
                    
                    if mysresponse.result.isSuccess {
                        let myResult = try? JSON(data: mysresponse.data!)
                        let resultArray = myResult![]
                        
        //                print(myResult)
                        
                        self.manager_firstname = resultArray["clicentinfo"]["manager_firstname"].stringValue
                        self.manager_lastname = resultArray["clicentinfo"]["manager_lastname"].stringValue
                        self.manager_mobile = resultArray["clicentinfo"]["manager_mobile"].stringValue
                        self.manager_sms_status = resultArray["clicentinfo"]["manager_sms_status"].stringValue
                        
                        self._FirstNameField.text = self.manager_firstname
                        self._lastNameField.text = self.manager_lastname
                        self._mobileField.text = self.manager_mobile
                        self.managerStatusDropDown.selectedIndex = Int(self.manager_sms_status)
                        
                        print("First name \(self.manager_firstname)")
                        
                        
                    }
                }
    }
    
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
                                          "manager_status" : String(managerStatus)]
        
        print(params)
        
        let mUrl = "\(StaticUrls.BASE_URL_FINAL)addclientmanager?"
        
        Alamofire.request(mUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                self.navigationController?.popViewController(animated: true)
                
                print(mysresponse)
  
            }
        }
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        addNewManager()
    }
}
