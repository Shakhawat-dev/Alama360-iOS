//
//  OtpAlertViewController.swift
//  Alama360
//
//  Created by Alama360 on 04/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
//import SVPinView
import Alamofire
import SwiftyJSON
import LanguageManager_iOS

class OtpAlertViewController: UIViewController {
    
    @IBOutlet weak var otpAlertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertInfo: UILabel!
//    @IBOutlet weak var pinview: SVPinView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var otpField: OTPTextField!
    @IBOutlet weak var invalidLabel: UILabel!
    
    //For storing user data
    let defaults = UserDefaults.standard
    var userLoggedIn: Bool = false
    var userexist = ""
    var code = ""
    var message = ""
    var userid = ""
    var usertype = ""
    var status = ""
    var phoneNumber = ""
    let lan = LanguageManager.shared.currentLanguage.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        self.hideKeyboardWhenTappedAround()
        
        localize()
        
        otpAlertView.layer.cornerRadius = 12
        DoLogin()
        
        otpField.configure()
        otpField.didEnterLastDigit = { [weak self] pinCode in
            print(pinCode)
            // Call for checking the pin
            self?.checkLogin (pinCode: pinCode)
        }
    }
    
    func localize() {
        alertTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_title", comment: "").localiz()
        alertInfo.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_message", comment: "").localiz() + " \(phoneNumber)"
        okBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_btn", comment: "").localiz(), for: .normal)
        
    }
    
    func checkLogin (pinCode: String) {
        if pinCode == self.code {
            if self.userexist == "1" {
                invalidLabel.text = ""
                self.userLoggedIn = true
                self.defaults.set(self.userLoggedIn, forKey: "loggedIn")
                
                // Move to Home
                Switcher.updateRootVC()
                
                defaults.set(userid, forKey: "userID")
                defaults.set(status, forKey: "Status")
                defaults.set(phoneNumber, forKey: "phoneNumber")
                defaults.set(lan, forKey: "language")
                
            } else {
                // Reg and Move to Home
                self.register()
            }
            
        } else {
            invalidLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_error", comment: "").localiz()
        }
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        
        if otpField.text == self.code {
            if self.userexist == "1" {
                invalidLabel.text = ""
                self.userLoggedIn = true
                self.defaults.set(self.userLoggedIn, forKey: "loggedIn")
                
                Switcher.updateRootVC()
                
                defaults.set(userid, forKey: "userID")
                defaults.set(status, forKey: "Status")
                defaults.set(phoneNumber, forKey: "phoneNumber")
                defaults.set(lan, forKey: "language")
                
            } else {
                self.register()
            }
            
        } else {
            invalidLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_error", comment: "").localiz()
        }
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
//        performSegue(withIdentifier: "backToLoginSegue", sender: nil)
        
        Switcher.updateRootVC()
    }
    
    func DoLogin() {
        
        let params : [String : String] = ["mobile" : phoneNumber, "lang" : lan]
        let nUrl = "https://alama360.com/api/userbymobile?"
        
        Alamofire.request(nUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
//                print(resultArray)
                
                self.userid = resultArray["userid"].stringValue
                self.status = resultArray["status"].stringValue
                self.code = resultArray["code"].stringValue
                self.message = resultArray["message"].stringValue
                self.userexist = resultArray["userexist"].stringValue
                self.usertype = resultArray["usertype"].stringValue
                
//                print("user id: \(self.userid)")
                print("verification code: \(self.code)")
                
                if self.usertype == "2919" {
                    self.defaults.set("owner", forKey: "userType")
                } else {
                    self.defaults.set("user", forKey: "userType")
                }
                
            }
            
        }
        
    }
    
    func register () {
//        print("ites here... \(phoneNumber)")
        
        let lan = LanguageManager.shared.currentLanguage.rawValue
        let params : [String : String] = ["mobile" : phoneNumber, "lang" : lan, "userid" : ""]
        let nUrl = "https://alama360.com/api/createOrupdateuser?"
        
        Alamofire.request(nUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
//                print(resultArray)
                
                self.userid = resultArray["userid"].stringValue
                self.status = resultArray["status"].stringValue
                self.message = resultArray["message"].stringValue
                self.usertype = resultArray["usertype"].stringValue
                
                if self.status == "1" {
                    self.userLoggedIn = true
                    self.defaults.set(self.userLoggedIn, forKey: "loggedIn")
                    Switcher.updateRootVC()
                }
                
                if self.usertype == "2919" {
                    self.defaults.set("owner", forKey: "userType")
                } else {
                    self.defaults.set("user", forKey: "userType")
                }
                
//                print("user id: \(self.userid)")
//                print("Message: \(self.message)")
                
                self.defaults.set(self.userid, forKey: "userID")
                self.defaults.set(self.phoneNumber, forKey: "phoneNumber")
                self.defaults.set(lan, forKey: "language")
                
            }
        }
        
    }

}
