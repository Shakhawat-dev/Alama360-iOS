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
    @IBOutlet weak var maritalStatus: UITextField!
    @IBOutlet weak var selectCountry: DropDown!

    @IBOutlet weak var selectState: DropDown!
    @IBOutlet weak var selectCity: DropDown!
    @IBOutlet weak var selectDistrict: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userId = defaults.string(forKey: "userID")!
        // Do any additional setup after loading the view.
        
        loadProfileData()
//        setTextFields()
    }
    
    func setTextFields() {
        
        firstName.setIcon(#imageLiteral(resourceName: "ic_first_name"))
        firstName.text = ftName
        
        lastName.setIcon(#imageLiteral(resourceName: "ic_last_name"))
        lastName.text = lName
        
        emailAddress.setIcon(#imageLiteral(resourceName: "ic_email"))
        emailAddress.text = email
        
        phoneNumber.setIcon(#imageLiteral(resourceName: "ic_phone_2"))
        phoneNumber.text = mobile
        
        dateOfBirth.setIcon(#imageLiteral(resourceName: "ic_dob"))
        dateOfBirth.text = dob
        
        maritalStatus.setIcon(#imageLiteral(resourceName: "ic_marit"))
        maritalStatus.text = marital_status
        
        selectCountry.setIcon(#imageLiteral(resourceName: "ic_country_2"))
        selectCountry.text = country
        
        selectState.setIcon(#imageLiteral(resourceName: "ic_state"))
        selectState.text = state
        
        selectCity.setIcon(#imageLiteral(resourceName: "ic_city"))
        selectCity.text = city
        
        selectDistrict.setIcon(#imageLiteral(resourceName: "ic_district"))
        selectDistrict.text = district
        
    }
    
    func loadProfileData() {
        SVProgressHUD.show()
        
        let pUrl = StaticUrls.BASE_URL_FINAL + "userinfo?lang=\(lan)&userid=\(userId)"
        print("Profile Url is: \(pUrl)")
        
        Alamofire.request(pUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                print(resultArray as Any)
                
                self.ftName = resultArray["name"].stringValue
                self.lName = resultArray["lname"].stringValue
                self.email = resultArray["email"].stringValue
                self.mobile = resultArray["mobile"].stringValue
                self.marital_status = resultArray["marital_status"].stringValue
                self.country = resultArray["country"].stringValue
                self.state = resultArray["state"].stringValue
                self.city = resultArray["city"].stringValue
                self.district = resultArray["district"].stringValue
                self.address = resultArray["address"].stringValue
                self.thumbnail = resultArray["thumbnail"].stringValue
                
                let countries = resultArray["userallcountry"].arrayValue
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
                                          "lang" : lan]
        
        Alamofire.request(pUpUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                print(resultArray)
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
        for i in countryArray {
            selectCountry.optionArray = [i.name]
        }
    }
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        updateProfileData()
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        
        //        toastContainer.addConstraints([a1, a2, a3, a4]
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconView.layoutMargins = UIEdgeInsets(top: 0,left: 8,bottom: 0,right: 8)
        //        let a1 = NSLayoutConstraint(item: iconView, attribute: .leading, relatedBy: .equal, toItem: iconContainerView, attribute: .leading, multiplier: 1, constant: 8)
        //        let a2 = NSLayoutConstraint(item: iconView, attribute: .trailing, relatedBy: .equal, toItem: iconContainerView, attribute: .trailing, multiplier: 1, constant: -8)
        
        
        
        iconContainerView.addSubview(iconView)
        //        iconView.addConstraints([a1, a2])
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
