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
    
    //For storing user data
    let defaults = UserDefaults.standard
    
    var rdParams: (title: String, city: String, district: String, thumbnail: String, id: String, man: Int, women: Int, checkinTime: String, checkOutTime: String)?
    var startDate = ""
    var endDate = ""
    var lan: String = ""
    var userId: String = ""
    var id: String?
    
    var pTitle: String?
    var pCityname: String?
    var pDistName: String?
    var thumbnail: String?
    var man: Int?
    var women: Int?
    var checkintime: String?
    var checkOutTime: String?
    
    var rentsalPriceArray = [RentalPriceModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        startDate = defaults.string(forKey: "firstDate")!
        endDate = defaults.string(forKey: "lastDate")!
        
        // Do any additional setup after loading the view.
        getRentalData()
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
                
                print("Prperty Rental Price array is: \(resultArray)")
                for i in resultArray.arrayValue {
                    let rentalPrice = RentalPriceModel(json: i)
                    self.rentsalPriceArray.append(rentalPrice)
                }
                
                // print("Rental Array is: \(self.rentsalPriceArray)")
                
                DispatchQueue.main.async {
                    self.reservationDetailsTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
                
            }
            
        }
    }
    
    
    @IBAction func completeReservationTapped(_ sender: Any) {
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
        reservationDetailsTableView.reloadData()
    }

}
