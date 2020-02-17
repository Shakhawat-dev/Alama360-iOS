//
//  WelcomeViewController.swift
//  Alama360
//
//  Created by Alama360 on 17/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import LanguageManager_iOS

class WelcomeViewController: UIViewController {

    @IBOutlet weak var imgChecked: UILabel!
    @IBOutlet weak var lblPaymentSuccesful: UILabel!
    @IBOutlet var viewTextContainer: [UIView]!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblEmailValue: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblMobileValue: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalValue: UILabel!
    @IBOutlet weak var lblTrxId: UILabel!
    @IBOutlet weak var lbltrxIdValue: UILabel!
    @IBOutlet weak var lblTrxDate: UILabel!
    @IBOutlet weak var lblTrxDateValue: UILabel!
    @IBOutlet weak var btnBackToHome: CustomBtnGreen!
    
    let defaults = UserDefaults.standard
    
    let lan = LanguageManager.shared.currentLanguage.rawValue
    
    var wcParams: (billFirstName: String, billlastName: String, phone: String, cc: String, email: String, total: Int, trxId: String, trxDate: String, propertyid: String, reserveItems: [RentalPriceModel])?
    
    var firstName: String = ""
    var lastName: String = ""
    var billAddress: String = ""
    var email: String = ""
    var phone: String = ""
    var totalAmount: String = ""
    var trxId: String = ""
    var trxDate: String = ""
    var propertyId: String = ""
    var countryCode: String = ""
    var rents = [RentalPriceModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        
        phone = defaults.string(forKey: "phoneNumber") ?? ""

        // Do any additional setup after loading the view.
        getSegueValues()
        setLocalization()
        setStyle()
        setValues()
        sendEmail()
    }
    
    func setLocalization() {
        lblPaymentSuccesful.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "payment_successful", comment: "").localiz()
        lblName.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "name", comment: "").localiz()
        lblEmail.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: "").localiz()
        lblMobile.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "mobile", comment: "").localiz()
        lblTotal.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "totalAmount", comment: "").localiz()
        lblTrxId.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "transactionId", comment: "").localiz()
        lblTrxDate.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "transactionDate", comment: "").localiz()
        btnBackToHome.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "backToHome", comment: "").localiz(), for: .normal)
    }
    
    func getSegueValues() {
        firstName = wcParams?.billFirstName ?? ""
        lastName = wcParams?.billlastName ?? ""
        email = wcParams?.email ?? ""
        totalAmount = String(wcParams?.total ?? 0)
        trxId = wcParams?.trxId ?? ""
        trxDate = wcParams?.trxDate ?? ""
        propertyId = wcParams?.propertyid ?? ""
        firstName = wcParams?.billFirstName ?? ""
        firstName = wcParams?.billFirstName ?? ""
        countryCode = wcParams?.cc ?? ""
        rents = wcParams!.reserveItems
        
//        print("rents is: \(firstName)")
        
    }
    
    func setStyle() {
        
        for view in viewTextContainer {
            view.layer.cornerRadius = 8
            view.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            view.layer.borderWidth = 1
            view.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
            view.layer.shadowRadius = 8
            view.layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        
    }
    
    func setValues() {
        lblNameValue.text = firstName
        lblEmailValue.text = email
        lblMobileValue.text = phone
        lblTotalValue.text = totalAmount
        lbltrxIdValue.text = trxId
        lblTrxDateValue.text = trxDate
    }
    
    func sendEmail() {
        
//        params.put("lang", new DataPreference(WelcomeActivity.this).getLanguage());
//                        params.put("bil_address", billAddress);
//                        params.put("bil_email", "alamdbz11@gmail.com");
//                        params.put("bil_first_name", firstName);
//                        params.put("bil_last_name", lastName);
//                        params.put("bil_phone", "531534038");
//                        params.put("formattedNumber", "+966531534038");
//        //                params.put("formattedNumber", "+"+formattedPhoneNo);
//                        params.put("phoneNumber", "531534038");
//                        params.put("countryCode", "SA");
//                        params.put("rentproperty_id", propertyId);
//                        params.put("cartinfo", jsonArray.toString());
        
//        for i in rents {
//            let id = i.id
//            let rentdate = i.rentdate
//            let price = i.price
//            let availabity = i.availabity
//        }
        
        let dicArray = rents.map { $0.convertToDictionary() }
        let cartinfo = JSON(dicArray)
        
//        if let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) {
//            let str = String(bytes: data, encoding: .utf8)
//        print(cartinfo.description)
//        }
        
        let params : [String : String] = ["lang" : lan,
                                          "bil_address" : billAddress,
                                          "bil_email" : "alamdbz11@gmail.com",
                                          "bil_first_name" : firstName,
                                          "bil_last_name" : lastName,
                                          "bil_phone" : "531534038",
                                          "formattedNumber" : "+966531534038",
                                          "phoneNumber" : "531534038",
                                          "countryCode" : "SA",
                                          "rentproperty_id" : propertyId,
                                          "cartinfo" : cartinfo.description]
    
        
        let nUrl = StaticUrls.BASE_URL_FINAL + "successurlandroid?"
        
        Alamofire.request(nUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
//                print(resultArray)
                

            }
        }
    }
    
    
    
    @IBAction func backtoHomeTapped(_ sender: Any) {
        Switcher.updateRootVC()
    }
    
}
