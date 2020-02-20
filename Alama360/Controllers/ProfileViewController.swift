//
//  ProfileViewController.swift
//  Alama360
//
//  Created by Alama360 on 16/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Alamofire
import SwiftyJSON
import SVProgressHUD
import iOSDropDown
import DatePickerDialog
import FSCalendar

class ProfileViewController: UIViewController {
    
    //For storing user data
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    var userId: String = ""
    
    var ftName: String = ""
    var lName: String = ""
    var email: String = ""
    var mobile: String = ""
    var personal_id: String = ""
    var dob: String = ""
    var marital_status: String = ""
    var country: String = ""
    var state: String = ""
    var city: String = ""
    var district: String = ""
    var address: String = ""
    var user_type: String = ""
    var thumbnail: String = ""
    var countryName: String = ""
    var stateName: String = ""
    var cityName: String = ""
    var districtName: String = ""
    
    var countryArray = [CountryModel]()
    var stateArray = [StateModel]()
    var cityArray = [CityModel]()
    var districtArray = [DistrictModel]()
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var maritalStatus: DropDown!
    @IBOutlet weak var selectCountry: DropDown!
    @IBOutlet weak var selectState: DropDown!
    @IBOutlet weak var selectCity: DropDown!
    @IBOutlet weak var selectDistrict: DropDown!
    @IBOutlet weak var btnUpdate: CustomBtnGreen!
    
    let datePicker = UIDatePicker()
    fileprivate weak var calendar: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        
        userId = defaults.string(forKey: "userID")!

        btnUpdate.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "btn_update", comment: "").localiz(), for: .normal)
        
        loadProfileData()
        setTextFields()
    }
    
    func setTextFields() {
        
        firstName.setIcon(#imageLiteral(resourceName: "ic_first_name"))
        firstName.text = ftName
        firstName.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "firstName", comment: "").localiz()
        
        lastName.setIcon(#imageLiteral(resourceName: "ic_last_name"))
        lastName.text = lName
        lastName.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "lastName", comment: "").localiz()
        
        emailAddress.setIcon(#imageLiteral(resourceName: "ic_email"))
        emailAddress.text = email
        emailAddress.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email_address", comment: "").localiz()
        
        phoneNumber.setIcon(#imageLiteral(resourceName: "ic_phone_2"))
        phoneNumber.text = mobile
        phoneNumber.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "mobile_no", comment: "").localiz()
        
        dateOfBirth.setIcon(#imageLiteral(resourceName: "ic_dob"))
        dateOfBirth.text = dob
        dateOfBirth.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "dob", comment: "").localiz()
        //                let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        //                       calendar.dataSource = self as? FSCalendarDataSource
        //                       calendar.delegate = self as? FSCalendarDelegate
        //                       dateOfBirth.inputView = calendar
        //                       self.calendar = calendar
        
        dateOfBirth.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale.init(localeIdentifier: "en") as Locale
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,flexSpace], animated: true)
        dateOfBirth.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        maritalStatus.setIcon(#imageLiteral(resourceName: "ic_marit"))
        maritalStatus.text = marital_status
        maritalStatus.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "marital_status", comment: "").localiz()
        
        selectCountry.setIcon(#imageLiteral(resourceName: "ic_country_2"))
        selectCountry.text = country
        selectCountry.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_country", comment: "").localiz()
        
        selectState.setIcon(#imageLiteral(resourceName: "ic_state"))
        selectState.text = state
        selectState.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_state", comment: "").localiz()
        
        selectCity.setIcon(#imageLiteral(resourceName: "ic_city"))
        selectCity.text = city
        selectCity.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_city", comment: "").localiz()
        
        selectDistrict.setIcon(#imageLiteral(resourceName: "ic_district"))
        selectDistrict.text = district
        selectDistrict.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_district", comment: "").localiz()
        
    }
    
    @objc func doneAction() {
        view.endEditing(true)
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
        dateOfBirth.text = dateFormatter.string(from: datePicker.date)
        //        view.endEditing(true)
    }
    
    func loadProfileData() {
        SVProgressHUD.show()
        
        //        let pUrl = StaticUrls.BASE_URL_FINAL + "userinfo?lang=\(lan)&userid=\(userId)"
        let pUrl = StaticUrls.BASE_URL_FINAL + "userinfo?lang=\(lan)&userid=\(userId)"
        print("Profile Url is: \(pUrl)")
        
        Alamofire.request(pUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                print(resultArray as Any)
                
                self.ftName = resultArray["name"].stringValue
                self.lName = resultArray["lname"].stringValue
                self.email = resultArray["email"].stringValue
                self.mobile = resultArray["mobile"].stringValue
                self.dob = resultArray["dob"].stringValue
                self.marital_status = resultArray["marital_status"].stringValue
                self.country = resultArray["country"].stringValue
                self.state = resultArray["state"].stringValue
                self.city = resultArray["city"].stringValue
                self.district = resultArray["district"].stringValue
                self.address = resultArray["address"].stringValue
                self.thumbnail = resultArray["thumbnail"].stringValue
                
                let countries = resultArray["userallcountry"].arrayValue
//                print("Country array is: \(countries)")
                
                for country in countries {
                    let newCountry = CountryModel(json: JSON(country))
                    self.countryArray.append(newCountry)
                }
                
                let states = resultArray["userallstate"].arrayValue
                for state in states {
                    let newState = StateModel(json: JSON(state))
                    self.stateArray.append(newState)
                }
                
                let cities = resultArray["userallcity"].arrayValue
                for city in cities {
                    let newCity = CityModel(json: JSON(city))
                    self.cityArray.append(newCity)
                }
                
                let districts = resultArray["useralldistrict"].arrayValue
                for district in districts {
                    let newDistrict = DistrictModel(json: JSON(district))
                    self.districtArray.append(newDistrict)
                }
                
            }
            self.setTextFields()
            self.setDropDowns()
            SVProgressHUD.dismiss()
        }
    }
    
    
    func updateProfileData() {
        SVProgressHUD.show()
        let pUpUrl = StaticUrls.BASE_URL_FINAL + "auth/updateprofile"
        print("Profile Url is: \(pUpUrl)")
        
        let params : [String : String] = ["userid" : userId,
                                          "name" : firstName.text ?? "",
                                          "lname" : lastName.text ?? "",
                                          "email" : emailAddress.text ?? "",
                                          "mobile" : mobile,
                                          "dob" : dateOfBirth.text ?? "",
                                          "marital_status" : maritalStatus.text ?? "",
                                          "country" : selectCountry.text ?? "",
                                          "state" : selectState.text ?? "",
                                          "city" : selectCity.text ?? "",
                                          "district" : selectDistrict.text ?? "",
                                          "lang" : lan]  // TODO: Change language
        
        Alamofire.request(pUpUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
//                print(resultArray)
                SVProgressHUD.dismiss()
                
                let aTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "updateAlertTitlle", comment: "").localiz()
                let aMessage = LocalizationSystem.sharedInstance.localizedStringForKey(key: "updateAlertMessage", comment: "").localiz()
                let aAction = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cOk", comment: "").localiz()
                
                let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: aAction, style: .default, handler: { _ in
                    //                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setDropDowns() {
        var ddCountries = [String]()
        var ddStates = [String]()
        var ddCities = [String]()
        var ddDistricts = [String]()
        
        maritalStatus.optionArray = [LocalizationSystem.sharedInstance.localizedStringForKey(key: "married", comment: "").localiz(), LocalizationSystem.sharedInstance.localizedStringForKey(key: "unmarried", comment: "").localiz()]
        
        for i in countryArray {
            ddCountries.append(i.name)
        }
        selectCountry.optionArray = ddCountries
        
        for i in stateArray {
            ddStates.append(i.name)
        }
        selectState.optionArray = ddStates
        
        for i in cityArray {
            ddCities.append(i.name)
        }
        selectCity.optionArray = ddCities
        
        for i in districtArray {
            ddDistricts.append(i.name)
        }
        selectDistrict.optionArray = ddDistricts
    }
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        updateProfileData()
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 0, y: 0, width: 22, height: 30))
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        //        toastContainer.addConstraints([a1, a2, a3, a4]
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 30, height: 30))
        iconView.layoutMargins = UIEdgeInsets(top: 0,left: 8,bottom: 0,right: 8)
        //        let a1 = NSLayoutConstraint(item: iconView, attribute: .leading, relatedBy: .equal, toItem: iconContainerView, attribute: .leading, multiplier: 1, constant: 8)
        //        let a2 = NSLayoutConstraint(item: iconView, attribute: .trailing, relatedBy: .equal, toItem: iconContainerView, attribute: .trailing, multiplier: 1, constant: -8)
        
        
        
        iconContainerView.addSubview(iconView)
        //        iconView.addConstraints([a1, a2])
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
