//
//  ViewController.swift
//  Alama360
//
//  Created by Alama360 on 10/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblCurrentLanguage: UILabel!
    @IBOutlet weak var btnChangeLanguage: UIButton!
    @IBOutlet weak var lblChalets: UILabel!
    @IBOutlet weak var lblSecure: UILabel!
    @IBOutlet weak var lblBooking: UILabel!
    @IBOutlet weak var lblVerified: UILabel!
    
    @IBOutlet weak var lblCountryCOde: UILabel!
    @IBOutlet weak var _phoneInput: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    //For storing user data
    let defaults = UserDefaults.standard

    var userexist = ""
    var code = ""
    var message = ""
    var userid = ""
    var usertype = ""
    var status = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeLanguage()
    
        lblCountryCOde.layer.cornerRadius = 4
        
    }

    @IBAction func changeLanguage(_ sender: Any) {
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
        } else {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft

        }
        
        changeLanguage()
        
    }
    
    @IBAction func _btnSubmit(_ sender: UIButton) {
        
        let phonenumber = _phoneInput.text
        
        if(phonenumber == "") {
            
            return
            
        }
        
        DoLogin(phonenumber!)
        
    }
    
    func DoLogin(_ phone:String) {
            
            let fPhone = "966"+phone
//            let lan = btnChangeLanguage.currentTitle!
            let lan = LocalizationSystem.sharedInstance.getLanguage()
        
            
            let params : [String : String] = ["mobile" : fPhone, "lang" : lan]

            let nUrl = "https://alama360.net/api/userbymobile?"

        Alamofire.request(nUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {

                let myResult = try? JSON(data: mysresponse.data!)

                let resultArray = myResult![]
                
                print(resultArray)

                self.userid = resultArray["userid"].stringValue
                self.status = resultArray["status"].stringValue
                self.code = resultArray["code"].stringValue
                self.message = resultArray["message"].stringValue
                self.userexist = resultArray["userexist"].stringValue
                self.usertype = resultArray["usertype"].stringValue
                
                print("user id: \(self.userid)")
                print("verification code: \(self.code)")

                
            }

        
                // For taking the value of action text field
                var inputTextField: UITextField?
                
            //Aler Dialoge Initiated
                let alert = UIAlertController(title: "Verification Code", message: "Enter the verification code recieved on the number \(fPhone)", preferredStyle: UIAlertController.Style.alert)

                alert.addTextField(configurationHandler: {(textField: UITextField!) in
                    textField.placeholder = "Four digit code:"
                    textField.isSecureTextEntry = false // for password input
                    
                    inputTextField = textField
                    
                })
                
                alert.addAction(UIAlertAction(title: "Next", style: UIAlertAction.Style.default, handler: { (action) -> Void in
                    print("Entered \(inputTextField?.text ?? "") ")
                    
                    if inputTextField?.text ?? "" == self.code {
                        
                        if self.userexist == "1" {
                            self.performSegue(withIdentifier: "HomePage", sender:nil)
                        } else {
                            self.register()
                        }

                        
                    }
                    
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
        
        defaults.set(userid, forKey: "userID")
        defaults.set(status, forKey: "Status")
        defaults.set(fPhone, forKey: "phoneNumber")
        defaults.set(lan, forKey: "language")
    
        
    
            
        }
       
        
    
    func changeLanguage() {
        
        lblHeader.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "header_text", comment: "")
        lblCurrentLanguage.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "change_language", comment: "")

        btnChangeLanguage.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "language", comment: ""), for: .normal)
        
        lblChalets.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "hundreds_of_chalets", comment: "")
        lblSecure.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "secure_payment", comment: "")
        lblVerified.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "verified_certified", comment: "")
        lblBooking.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirm_booking", comment: "")
        btnSubmit.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "btn_submit", comment: ""), for: .normal)
        
    }
    
    func register () {
        
        let regPhone = _phoneInput.text
        
        print("ites here... \(regPhone)")
        
        let lan = btnChangeLanguage.currentTitle!
        
            
        let params : [String : String] = ["mobile" : regPhone!, "lang" : "en"]

            let nUrl = "https://alama360.net/api/createOrupdateuser?"

        Alamofire.request(nUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {

                let myResult = try? JSON(data: mysresponse.data!)

                let resultArray = myResult![]
                
                print(resultArray)

                self.userid = resultArray["userid"].stringValue
                self.status = resultArray["status"].stringValue
//                self.code = resultArray["code"].stringValue
                self.message = resultArray["message"].stringValue
//                self.userexist = resultArray["userexist"].stringValue
                self.usertype = resultArray["usertype"].stringValue
                
                if self.status == "1" {
                    self.performSegue(withIdentifier: "HomePage", sender:nil)
                }
//
                print("user id: \(self.userid)")
                print("Message: \(self.message)")
        
            }
        }
        
    }
    
    
}

