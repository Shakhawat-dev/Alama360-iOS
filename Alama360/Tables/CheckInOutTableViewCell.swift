//
//  CheckInOutTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class CheckInOutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkinContainerView: UIView!
    @IBOutlet weak var checkInStartLbl: UILabel!
    @IBOutlet weak var checkInStartTimeLbl: UILabel!
    @IBOutlet weak var checkOutStartLbl: UILabel!
    @IBOutlet weak var checkoutStartTimeLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var totalpriceValueLbl: UILabel!
    @IBOutlet weak var checkInStack: UIStackView!
    @IBOutlet weak var checkOutStack: UIStackView!
    @IBOutlet weak var tottalStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkinContainerView.layer.cornerRadius = 8
        checkinContainerView.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        checkinContainerView.layer.shadowRadius = 8
        checkinContainerView.layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        checkInStartLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "check_start_time", comment: "").localiz()
        checkOutStartLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "check_out_time", comment: "").localiz()
        totalPriceLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "total_price", comment: "").localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues(price: [RentalPriceModel], checkIn: String, checkOut: String) {

        var total: Int = 0
        for i in price {
            
            if i.availabity == "1" {
                total += Int(i.price!)!
            }
            
        }
        if checkIn == "" && checkOut == "" {
            checkInStack.isHidden = true
            checkOutStack.isHidden = true
        } else if checkIn == "" && checkOut != ""  {
            checkInStack.isHidden = true
            checkoutStartTimeLbl.text = ": " + checkOut
        } else if checkIn != "" && checkOut == ""  {
            checkOutStack.isHidden = true
            checkInStartTimeLbl.text = ": " + checkIn
        }
        
        totalpriceValueLbl.text = ": " + LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "").localiz() + " \(total)"
    }

}
