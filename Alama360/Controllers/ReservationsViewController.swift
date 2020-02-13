//
//  ReservationsViewController.swift
//  Alama360
//
//  Created by Alama360 on 12/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReservationsViewController: UIViewController{
    
    @IBOutlet weak var reservationTable: UITableView!
    
    let defaults = UserDefaults.standard
    
    // Param Variables
    var lan = ""
    var id = ""
    
    var reservationArray = [ReservationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // getting default values
        lan = LocalizationSystem.sharedInstance.getLanguage()
        id = defaults.string(forKey: "userID")!
        
//        let logo = #imageLiteral(resourceName: "logo")
//        let imageView = UIImageView(image:logo)
//        let title = UILabel("Reservations")
        
        self.navigationItem.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "reservations", comment: "").localiz()
        
        loadReservation()
        reservationTable.delegate = self
        reservationTable.dataSource = self
    }
    
    func loadReservation() {
        let rUrl = StaticUrls.BASE_URL_FINAL + "fetch_customer_bookings?lang=\(lan)&userid=140"
        
        Alamofire.request(rUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["reservations"]
                
                let dataArray = resultArray["data"]
                print(resultArray as Any)
//                print(dataArray as Any)
                
                // Initiatoing resultArray into specific array
                for i in dataArray.arrayValue {
                    
                    let newReserv = ReservationModel(json: i)
                    self.reservationArray.append(newReserv)
//                     print(self.reservationArray)
                    
                    self.reservationTable.reloadData()
                }
                
            }
        }
    }
}

extension ReservationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reservationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationTableViewCell", for: indexPath) as! ReservationTableViewCell
        cell.setValues(reserveData: reservationArray[indexPath.row])
        
        return cell
    }
    
    
}


