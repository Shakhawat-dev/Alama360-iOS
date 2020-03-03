//
//  AddBankViewController.swift
//  Alama360
//
//  Created by Alama360 on 08/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import iOSDropDown
import Alamofire
import SwiftyJSON
import LanguageManager_iOS

class AddBankViewController: UIViewController {

    @IBOutlet weak var lblBankHeader: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var bankNameDropDown: DropDown!
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var _BankHolderNameField: UITextField!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var _AccountNumberField: UITextField!
    @IBOutlet weak var lblIBANBumber: UILabel!
    @IBOutlet weak var _IBANField: UITextField!
    @IBOutlet weak var btnSave: CustomBtnGreen!
    
    //For storing user data
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    var userId: String = ""
    var id: String = ""
    var bankArray = [CategoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For Hiding keyboard on Tap
        self.hideKeyboardWhenTappedAround()
        // Getting User Details
        userId = defaults.string(forKey: "userID")!
        
        // Do any additional setup after loading the view.
        getBanks()
        
    }
    
    func getBanks() {
        let tUrl = StaticUrls.BASE_URL_FINAL + "getLookUpByCat/66?lang=en&limit=30"
        
        Alamofire.request(tUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                //              print(resultArray)
                for i in resultArray.arrayValue {
                    let bank = CategoryModel(json: i)
                    self.bankArray.append(bank)
                }
                                print(self.bankArray)
                self.setViews()
                
            }
        }
    }
    
    func setViews() {
        
        var banks = [String]()
        var bankIDs = [Int]()
        
        for i in bankArray {
            let bank = i.col1
            let bankId = i.id
            
            banks.append(bank)
            if let iBank = Int(bankId) {
                bankIDs.append(iBank)
            }
            bankNameDropDown.optionArray = banks
            bankNameDropDown.optionIds = bankIDs
        }
        
        
    }
    
    func addNewBank() {
       
          let params : [String : String] = ["lang" : "en",
                                            "property_title" : "",
                                            "slug" : "",
                                            "property_id" : id,
                                            "userid" : userId,
                                            "author_id" : userId,
                                            "bank" : bankNameDropDown.text ?? "",
                                            "account_holder_name" : _BankHolderNameField.text ?? "",
                                            "bankaccount_number" : _AccountNumberField.text ?? "",
                                            "iban_number" : _IBANField.text ?? ""]
          
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
         addNewBank()
    }
}

extension AddBankViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 22
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
    }
}
