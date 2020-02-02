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
import SVPinView

class ViewController: UIViewController {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    @IBOutlet weak var btnChangeLanguage: UIButton!
    @IBOutlet weak var lblChalets: UILabel!
    @IBOutlet weak var lblSecure: UILabel!
    @IBOutlet weak var lblBooking: UILabel!
    @IBOutlet weak var lblVerified: UILabel!
    
    @IBOutlet weak var ccField: UITextField!
    @IBOutlet weak var _phoneInput: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtFieldholderVIew: UIView!
    @IBOutlet weak var textFieldStackView: UIStackView!
    
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

        _phoneInput.delegate = self
        
        ccField.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        _phoneInput.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        txtFieldholderVIew.semanticContentAttribute = .forceLeftToRight
        textFieldStackView.semanticContentAttribute = .forceLeftToRight
        
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
    
    func changeLanguage() {
        
        lblHeader.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "header_text", comment: "").localiz()
        lblSubHeader.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sub_header", comment: "").localiz()
        
        btnChangeLanguage.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "language", comment: "").localiz(), for: .normal)
        
        lblChalets.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "hundreds_of_chalets", comment: "").localiz()
        lblSecure.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "secure_payment", comment: "").localiz()
        lblVerified.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "verified_certified", comment: "").localiz()
        lblBooking.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirm_booking", comment: "").localiz()
        btnSubmit.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "btn_submit", comment: "").localiz(), for: .normal)
        
        //        lblHeader.text = NSLocalizedString("header_text", comment: "").localiz()
        //        lblCurrentLanguage.text = NSLocalizedString("chage_language", comment: "").localiz()
        
        
        
    }
    
    func checkLogin() {
        
    }
    
    @IBAction func _btnSubmit(_ sender: UIButton) {
        
        let phonenumber = _phoneInput.text
        
        if(phonenumber == "") {
            
            let alert = UIAlertController(title: "Enter Number!", message: "Please Enter your mobile number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
            
        } else {
            let fPhone = "966" + phonenumber!
            performSegue(withIdentifier: "pinviewSegue", sender: fPhone)
        }
    }
    
    // Sending Data to View COntroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pinviewSegue" {
            let destVC = segue.destination as! OtpAlertViewController
            destVC.phoneNumber = sender as! String
        }
    }

    @IBAction func jdsg(_ sender: Any) {
//        print("here \(_phoneInput.text)")
        let mynum = Int(_phoneInput.text!)
        let mynumstring = _phoneInput.text!
        if(mynumstring.count>8){
        _phoneInput.text = String(mynum!)
        }
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 9
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
    }
}
