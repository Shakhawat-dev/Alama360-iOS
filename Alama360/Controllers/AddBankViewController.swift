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
    @IBOutlet weak var lblIBANerror: UILabel!
    @IBOutlet weak var ibanStackView: UIStackView!
    
    //For storing user data
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    var userId: String = ""
    var id: String = ""
    var bankArray = [CategoryModel]()
    var bankID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For Hiding keyboard on Tap
        self.hideKeyboardWhenTappedAround()
        // Getting User Details
        userId = defaults.string(forKey: "userID")!
        
        _IBANField.delegate = self
        
        // Do any additional setup after loading the view.
        getBanks()
        
        bankNameDropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index) \n id: \(id)")
            self.bankID = id
        }
        
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
        
        ibanStackView.semanticContentAttribute = .forceLeftToRight
        
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
                                          "bank" : String(bankID),
                                          "account_holder_name" : _BankHolderNameField.text ?? "",
                                          "bankaccount_number" : _AccountNumberField.text ?? "",
                                          "iban_number" : "SA" + _IBANField.text!]
        
        print(params)
        
        let mUrl = "\(StaticUrls.BASE_URL_FINAL)addclientbank?"
        
        Alamofire.request(mUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                print(mysresponse)
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if (!bankNameDropDown.text!.isEmpty && !_BankHolderNameField.text!.isEmpty && !_AccountNumberField.text!.isEmpty && !_IBANField.text!.isEmpty ) {
            addNewBank()
        } else {
            let alert = UIAlertController(title: "Warning", message: "All Fields are required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                //                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension AddBankViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblIBANerror.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 < 22 {
            lblIBANerror.text = "*Invalid number"
            lblIBANerror.isHidden = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 22
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        
    }
}
