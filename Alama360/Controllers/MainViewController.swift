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
import LanguageManager_iOS

class ViewController: UIViewController {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblCurrentLanguage: UILabel!
    @IBOutlet weak var btnChangeLanguage: UIButton!
    @IBOutlet weak var lblChalets: UILabel!
    @IBOutlet weak var lblSecure: UILabel!
    @IBOutlet weak var lblBooking: UILabel!
    @IBOutlet weak var lblVerified: UILabel!
    
    @IBOutlet weak var ccField: UITextField!
    @IBOutlet weak var _phoneInput: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtFieldholderVIew: UIView!
    
    //For storing user data
    let defaults = UserDefaults.standard
    var userLoggedIn: Bool = false
    var userexist = ""
    var code = ""
    var message = ""
    var userid = ""
    var usertype = ""
    var status = ""
    
    //HomePage segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        ccField.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        _phoneInput.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        txtFieldholderVIew.semanticContentAttribute = .forceLeftToRight
        
        changeLanguage()
        checkLogin()
//        changeLanguage()
    }
    @IBAction func btnLangguage(_ sender: UIButton) {
//        if LanguageManager.shared.currentLanguage.rawValue == "ar" {
//            // change the language
//            LanguageManager.shared.setLanguage(language: .en, viewControllerFactory: { title -> UIViewController in
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                // the view controller that you want to show after changing the language
//                return storyboard.instantiateInitialViewController()!
//            }) { view in
//                view.transform = CGAffineTransform(scaleX: 2, y: 2)
//                view.alpha = 0
//            }
//            changeLanguage()
//        } else {
//            LanguageManager.shared.setLanguage(language: .ar, viewControllerFactory: { title -> UIViewController in
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                // the view controller that you want to show after changing the language
//                return storyboard.instantiateInitialViewController()!
//            }) { view in
//                view.transform = CGAffineTransform(scaleX: 2, y: 2)
//                view.alpha = 0
//            }
//            changeLanguage()
//        }
//
        
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")

            // UIView.appearance().semanticContentAttribute = .forceLeftToRight

            // change the language
            LanguageManager.shared.setLanguage(language: .en,
                                                  viewControllerFactory: { title -> UIViewController in
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 // the view controller that you want to show after changing the language
                 return storyboard.instantiateInitialViewController()!
               }) { view in
                 view.transform = CGAffineTransform(scaleX: 2, y: 2)
                 view.alpha = 0
               }

        } else {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")

            // UIView.appearance().semanticContentAttribute = .forceRightToLeft

            // change the language
            LanguageManager.shared.setLanguage(language: .ar,
                                                  viewControllerFactory: { title -> UIViewController in
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 // the view controller that you want to show after changing the language
                 return storyboard.instantiateInitialViewController()!
               }) { view in
                 view.transform = CGAffineTransform(scaleX: 2, y: 2)
                 view.alpha = 0
               }
        }

//        let vc = self.storyboard?.instantiateInitialViewController() as! ViewController
//        let appDlg = UIApplication.shared.delegate as! AppDelegate
//        appDlg.window?.rootViewController = vc

        changeLanguage()
        
        
    }
    
    func checkLogin() {
        
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
        let lan = LanguageManager.shared.currentLanguage.rawValue
        
        
        let params : [String : String] = ["mobile" : fPhone, "lang" : lan]
        
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
            var inputTextField: UITextField?
            let alertTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_title", comment: "").localiz()
            let alertMessage = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_message", comment: "").localiz()
            let alertBtn = LocalizationSystem.sharedInstance.localizedStringForKey(key: "alert_btn", comment: "").localiz()
            
            //Aler Dialoge Initiated
            let alert = UIAlertController(title: alertTitle, message: alertMessage + " \(fPhone)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField(configurationHandler: {(textField: UITextField!) in
//                textField.placeholder = "Four digit code:"
//                textField.type
                textField.keyboardType = .numberPad
                textField.textContentType = .oneTimeCode
                textField.isSecureTextEntry = false // for password input
                
                inputTextField = textField
                
            })
            
            alert.addAction(UIAlertAction(title: alertBtn, style: UIAlertAction.Style.default, handler: { (action) -> Void in
                print("Entered \(inputTextField?.text ?? "") ")
                
                if inputTextField?.text ?? "" == self.code {
                    
                    if self.userexist == "1" {
//                        self.performSegue(withIdentifier: "HomePage", sender:nil)
                        self.userLoggedIn = true
                        self.defaults.set(self.userLoggedIn, forKey: "loggedIn")
                        Switcher.updateRootVC()
                        
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
        
        lblHeader.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "header_text", comment: "").localiz()
        lblCurrentLanguage.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "change_language", comment: "").localiz()

        btnChangeLanguage.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "language", comment: "").localiz(), for: .normal)

        lblChalets.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "hundreds_of_chalets", comment: "").localiz()
        lblSecure.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "secure_payment", comment: "").localiz()
        lblVerified.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "verified_certified", comment: "").localiz()
        lblBooking.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirm_booking", comment: "").localiz()
        btnSubmit.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "btn_submit", comment: "").localiz(), for: .normal)
        
//        lblHeader.text = NSLocalizedString("header_text", comment: "").localiz()
//        lblCurrentLanguage.text = NSLocalizedString("chage_language", comment: "").localiz()
        
         
        
    }
    
    func register () {
        
        let regPhone = _phoneInput.text
        
        print("ites here... \(regPhone)")
        
        let lan = LanguageManager.shared.currentLanguage.rawValue
        
        
        let params : [String : String] = ["mobile" : regPhone!, "lang" : lan, "userid" : ""]
        
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
                self.defaults.set(regPhone, forKey: "phoneNumber")
                self.defaults.set(lan, forKey: "language")
                
            }
        }
        
    }
    
    
}

