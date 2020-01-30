//
//  OtpAlertViewController.swift
//  Alama360
//
//  Created by Alama360 on 04/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import SVPinView
import Alamofire
import SwiftyJSON
import LanguageManager_iOS

class OtpAlertViewController: UIViewController {

    @IBOutlet weak var otpAlertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertInfo: UILabel!
    @IBOutlet weak var pinview: SVPinView!
    @IBOutlet weak var okBtn: UIButton!
    
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

        localize()
        
        otpAlertView.layer.cornerRadius = 12
        DoLogin()
        
        // Do any additional setup after loading the view.
    }
    
    func localize() {
        alertTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_title", comment: "").localiz()
        alertInfo.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_message", comment: "").localiz() + " \(phoneNumber)"
        okBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_btn", comment: "").localiz(), for: .normal)
        
        pinview.semanticContentAttribute = .forceLeftToRight
        pinview.isContentTypeOneTimeCode = true
        
        
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        
        if pinview.getPin() == self.code {
            if self.userexist == "1" {
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
            
        }
        
        pinview.didFinishCallback = { pin in
            print("The pin entered is \(pin)")
            
            
            
        }
        
        //        if userexist == "1" {
        //            Switcher.updateRootVC()
        //            self.userLoggedIn = true
        //            self.defaults.set(self.userLoggedIn, forKey: "loggedIn")
        //            Switcher.updateRootVC()
        //
        //            // Seting defaults
        //            defaults.set(userid, forKey: "userID")
        //            defaults.set(status, forKey: "Status")
        //            defaults.set(phoneNumber, forKey: "phoneNumber")
        //            defaults.set(lan, forKey: "language")
        //
        //        } else {
        //            register()
        //        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToLoginSegue", sender: nil)
    }
    
    func DoLogin() {
        
//        let fPhone = "966"+phone
        //            let lan = btnChangeLanguage.currentTitle!
        
        
        
        let params : [String : String] = ["mobile" : phoneNumber, "lang" : lan]
        
        let nUrl = "https://alama360.com/api/userbymobile?"
        
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
//            var inputTextField: UITextField?
//            let alertTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_title", comment: "").localiz()
//            let alertMessage = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_message", comment: "").localiz()
//            let alertBtn = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_btn", comment: "").localiz()
//
            //Aler Dialoge Initiated
//            let alert = UIAlertController(title: alertTitle, message: alertMessage + " \(fPhone)", preferredStyle: UIAlertController.Style.alert)
//
//            alert.addTextField(configurationHandler: {(textField: UITextField!) in
//                //                textField.placeholder = "Four digit code:"
//                //                textField.type
//                textField.keyboardType = .numberPad
//                textField.textContentType = .oneTimeCode
//                textField.isSecureTextEntry = false // for password input
//
//                inputTextField = textField
//
//            })
            
            
//            alert.addAction(UIAlertAction(title: alertBtn, style: UIAlertAction.Style.default, handler: { (action) -> Void in
//                print("Entered \(inputTextField?.text ?? "") ")
//
//                if inputTextField?.text ?? "" == self.code {
//
//                    if self.userexist == "1" {
//                        //                        self.performSegue(withIdentifier: "HomePage", sender:nil)
//                        self.userLoggedIn = true
//                        self.defaults.set(self.userLoggedIn, forKey: "loggedIn")
//                        Switcher.updateRootVC()
//
//                    } else {
//                        self.register()
//
//                    }
//
//                }
//
//            }))
            
            //            self.present(alert, animated: true, completion: nil)
            //            OtpAlertView.instance.showAlert(title: "Hellooo", message: "This is a test run...")
            
//            self.performSegue(withIdentifier: "pinviewSegue", sender: nil)
            
        }
        
        
        
//        defaults.set(userid, forKey: "userID")
//        defaults.set(status, forKey: "Status")
//        defaults.set(phoneNumber, forKey: "phoneNumber")
//        defaults.set(lan, forKey: "language")
        
        
        
        
    }
    
    
    
    
    
    func register () {
        
//        let regPhone = _phoneInput.text
        
        print("ites here... \(phoneNumber)")
        
        let lan = LanguageManager.shared.currentLanguage.rawValue
        
        
        let params : [String : String] = ["mobile" : phoneNumber, "lang" : lan, "userid" : ""]
        
        let nUrl = "https://alama360.com/api/createOrupdateuser?"
        
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
                    //                    self.performSegue(withIdentifier: "HomePage", sender:nil)
                    self.userLoggedIn = true
                    self.defaults.set(self.userLoggedIn, forKey: "loggedIn")
                    Switcher.updateRootVC()
                }
                //
                print("user id: \(self.userid)")
                print("Message: \(self.message)")
                
                self.defaults.set(self.userid, forKey: "userID")
                self.defaults.set(self.phoneNumber, forKey: "phoneNumber")
                self.defaults.set(lan, forKey: "language")
                
            }
        }
        
    }
    

}
