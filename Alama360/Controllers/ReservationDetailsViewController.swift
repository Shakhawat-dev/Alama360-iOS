//
//  ReservationDetailsViewController.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import LanguageManager_iOS
import SVProgressHUD

class ReservationDetailsViewController: UIViewController {
    
    @IBOutlet weak var reservationDetailsTableView: UITableView!
    @IBOutlet weak var completeReservationBtn: CustomBtnGreen!
    
    var initialSetupViewController: PTFWInitialSetupViewController!
    //For storing user data
    let defaults = UserDefaults.standard
    
    var rdParams: (title: String, city: String, district: String, thumbnail: String, id: String, man: Int, women: Int, checkinTime: String, checkOutTime: String)?
    var startDate = ""
    var endDate = ""
    var lan: String = ""
    var userId: String = ""
    var id: String?
    var phone: String = ""
    
    var pTitle: String?
    var pCityname: String?
    var pDistName: String?
    var thumbnail: String?
    var man: Int?
    var women: Int?
    var checkintime: String?
    var checkOutTime: String?
    var totalPrice: Int = 0
    
    var firstName: String?
    var lastName: String?
    var billPhone: String?
    var countryCode: String?
    var email: String?
    var trxId: String?
    var trxDate: String?
    var country: String?
    var state: String?
    var city: String?
    var district: String?
    var address: String?
    
    var rentsalPriceArray = [RentalPriceModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        completeReservationBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "complete_reservations", comment: "").localiz(),for: .normal)
        
        // Setting values from segue data
        pTitle = rdParams?.title
        pCityname = rdParams?.city
        pDistName = rdParams?.district
        thumbnail = rdParams?.thumbnail
        id = rdParams?.id
        man = rdParams?.man
        women = rdParams?.women
        checkintime = rdParams?.checkinTime
        checkOutTime = rdParams?.checkOutTime
        
        phone = defaults.string(forKey: "phoneNumber") ?? ""
        userId = defaults.string(forKey: "userID") ?? ""
        startDate = defaults.string(forKey: "firstDate") ?? ""
        endDate = defaults.string(forKey: "lastDate") ?? ""
        
        // Do any additional setup after loading the view.
        getRentalData()
        loadProfileData()
    }
    
    func getRentalData() {
        
        SVProgressHUD.show()
        lan = LanguageManager.shared.currentLanguage.rawValue
        
        let pdUrl = StaticUrls.BASE_URL_FINAL + "getandroiddailyrentalprice?lang=\(lan)&propertyid=\(id!)&startdate=\(startDate)&enddate=\(endDate)"
        
        // URL check
        print("Response bUrl is: \(pdUrl)")
        
        Alamofire.request(pdUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            if mysresponse.result.isSuccess {
                
                self.reservationDetailsTableView.delegate = self
                self.reservationDetailsTableView.dataSource = self
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                print("Prperty Rental Price array is: \(resultArray)")
                for i in resultArray.arrayValue {
                    let rentalPrice = RentalPriceModel(json: i)
                    self.rentsalPriceArray.append(rentalPrice)
                }
                
//                print("Rental Array is: \(self.rentsalPriceArray)")
                
                DispatchQueue.main.async {
                    self.reservationDetailsTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
                
            }
            
        }
    }
    
    func loadProfileData() {
        SVProgressHUD.show()
        
        //        let pUrl = StaticUrls.BASE_URL_FINAL + "userinfo?lang=\(lan)&userid=\(userId)"
        let pUrl = StaticUrls.BASE_URL_FINAL + "userinfo?lang=en&userid=\(userId)"
        print("Profile Url is: \(pUrl)")
        
        Alamofire.request(pUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                print(resultArray as Any)
                
                self.firstName = resultArray["name"].stringValue
                self.lastName = resultArray["lname"].stringValue
                self.email = resultArray["email"].stringValue
//                self.mobile = resultArray["mobile"].stringValue
//                self.dob = resultArray["dob"].stringValue
//                self.marital_status = resultArray["marital_status"].stringValue
                self.country = resultArray["country"].stringValue
                self.state = resultArray["state"].stringValue
                self.city = resultArray["city"].stringValue
                self.district = resultArray["district"].stringValue
                self.address = resultArray["address"].stringValue
                self.thumbnail = resultArray["thumbnail"].stringValue
                
//                let countries = resultArray["userallcountry"].arrayValue
//                print("Country array is: \(self.address)")
//
//                for country in countries {
//                    let newCountry = CountryModel(json: JSON(country))
//                    self.countryArray.append(newCountry)
//                }
//
//                let states = resultArray["userallstate"].arrayValue
//                for state in states {
//                    let newState = StateModel(json: JSON(state))
//                    self.stateArray.append(newState)
//                }
//
//                let cities = resultArray["userallcity"].arrayValue
//                for city in cities {
//                    let newCity = CityModel(json: JSON(city))
//                    self.cityArray.append(newCity)
//                }
//
//                let districts = resultArray["useralldistrict"].arrayValue
//                for district in districts {
//                    let newDistrict = DistrictModel(json: JSON(district))
//                    self.districtArray.append(newDistrict)
//                }
                
            }
//            self.setTextFields()
//            self.setDropDowns()
            SVProgressHUD.dismiss()
        }
    }
    
    func calcTotalPrice() {
        var total: Int = 0
        for i in rentsalPriceArray {
            
            if i.availabity == "1" {
                total += Int(i.price!)!
            }
            
        }
        
        totalPrice = total
//        print("Total is: \(totalPrice)")
    }
    
    @IBAction func completeReservationTapped(_ sender: Any) {
        
        calcTotalPrice()
//         print("Rental Array is: \(rentsalPriceArray)")
        
//        let dicArray = rentsalPriceArray.map { $0.convertToDictionary() }
//        let json = JSON(dicArray)
//        if let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) {
//            let str = String(bytes: data, encoding: .utf8)
//        print(json)
//        }
        
        let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: bundle,
            andWithViewFrame: self.view.frame,
            andWithAmount: Float(totalPrice),
            andWithCustomerTitle: "Alama360",
            andWithCurrencyCode: "SAR",
            andWithTaxAmount: 0.0,
            andWithSDKLanguage: lan,
            andWithShippingAddress: "Saudi Arabia",
            andWithShippingCity: "Manama",
            andWithShippingCountry: "BHR", //"BHR"
            andWithShippingState: "Manama",
            andWithShippingZIPCode: "123456",
            andWithBillingAddress: "Manama",
            andWithBillingCity: "Manama",
            andWithBillingCountry: "BHR",
            andWithBillingState: "Manama",
            andWithBillingZIPCode: "12345",
            andWithOrderID: "12345",
            andWithPhoneNumber: "00" + phone,
            andWithCustomerEmail: "example@email.com",
            andIsTokenization:false,
            andIsPreAuth: false,
            andWithMerchantEmail: "ali@alama360.com",
            andWithMerchantSecretKey: "hOPwWPG56S5qy8brwX8JLHdVKmqXbiWt7M04BG9Hzf78njAUgIE1pSWafn7qG4UNQUSrB19ahhjFATAQBeR16OblcjMSnGGeByFc",
            andWithAssigneeCode: "SDK",
            andWithThemeColor:#colorLiteral(red: 0, green: 0.6532471776, blue: 0.4756888151, alpha: 1),
            andIsThemeColorLight: false)
        
        
        self.initialSetupViewController.didReceiveBackButtonCallback = {
            
        }
        
        self.initialSetupViewController.didStartPreparePaymentPage = {
            // Start Prepare Payment Page
            // Show loading indicator
        }
        self.initialSetupViewController.didFinishPreparePaymentPage = {
            // Finish Prepare Payment Page
            // Stop loading indicator
        }
        
        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            print("Response Code: \(responseCode)")
            print("Response Result: \(result)")
            
            // In Case you are using tokenization
            print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
            print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
            print("TOkenization Token: \(token)");
            
            if responseCode == 100 {
                let reserveParam = (billFirstName : self.firstName,
                                    billlastName : self.lastName,
                                    phone: self.billPhone,
                                    cc: self.countryCode,
                                    email: self.email,
                                    total: self.totalPrice,
                                    trxId: transactionID,
                                    trxDate: self.trxDate,
                                    propertyid: self.id,
                                    reserveItems: self.rentsalPriceArray)
                
//                print("property Param is : \(reserveParam)")
                
                self.performSegue(withIdentifier: "rdtoWC", sender: reserveParam)
            }
            
            
        }

        self.view.addSubview(initialSetupViewController.view)
        self.addChild(initialSetupViewController)
        
        initialSetupViewController.didMove(toParent: self)
    }
    
    // Sending Data to View COntroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rdtoWC" {
            let destVC = segue.destination as! WelcomeViewController
            destVC.wcParams = sender as? (billFirstName: String, billlastName: String, phone: String, cc: String, email: String, total: Int, trxId: String, trxDate: String, propertyid: String, reserveItems: [RentalPriceModel])
        }
    }
    
    @IBAction func testTapped(_ sender: Any) {
        let reserveParam = (billFirstName : firstName,
                            billlastName : lastName,
                            phone: billPhone,
                            cc: countryCode,
                            email: email,
                            total: totalPrice,
                            trxId: trxId,
                            trxDate: trxDate,
                            propertyid: id,
                            reserveItems: rentsalPriceArray)

//        print("property Param is : \(reserveParam)")

        performSegue(withIdentifier: "rdtoWC", sender: reserveParam)
    }
    
    
}

extension ReservationDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return rentsalPriceArray.count
        } else if section == 2{
            return 2
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationprogressTableViewCell") as! ReservationprogressTableViewCell
            
            return cell
        } else if indexPath.section == 0 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationDetailsTableViewCell") as! ReservationDetailsTableViewCell
            
            cell.setPropertyInfo(thumb: thumbnail!, title: pTitle!, city: pCityname!, dist: pDistName!, man: man!, women: women!)
            
            return cell
        }
        else if indexPath.section == 0 && indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RDdatePriceTitleTableViewCell") as! RDdatePriceTitleTableViewCell

            return cell
        }
        
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RDdatesPriceTableViewCell") as! RDdatesPriceTableViewCell

            cell.setPrices(rentalPrices: rentsalPriceArray[indexPath.row])
            cell.delegate = self
            cell.index = indexPath
            
            return cell
        }
        else if indexPath.section == 2 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInOutTableViewCell") as! CheckInOutTableViewCell

            cell.setValues(price: rentsalPriceArray, checkIn: checkintime!, checkOut: checkOutTime!)

            return cell
        }
        else if indexPath.section == 2 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RefundPolicyTableViewCell") as! RefundPolicyTableViewCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RefundPolicyTableViewCell") as! RefundPolicyTableViewCell
            
            return cell
        }
    }
    
    
}

extension ReservationDetailsViewController: PriceCellDelegate {
    func didTapDelBtn(index: Int) {
        rentsalPriceArray.remove(at: index)
        
        calcTotalPrice()                                          
        
        reservationDetailsTableView.reloadData()
    }

}
