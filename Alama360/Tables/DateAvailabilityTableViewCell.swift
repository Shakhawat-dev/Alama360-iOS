//
//  DateAvailabilityTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 11/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class DateAvailabilityTableViewCell: UITableViewCell {

    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues(rentalPrices: RentalPriceModel) {
        
        dateLabel.text = rentalPrices.rentdate
        priceLabel.text = rentalPrices.price

        if rentalPrices.availabity == "1" {
            availabilityLabel.textColor = #colorLiteral(red: 0.02439633612, green: 0.6269035533, blue: 0.4417837247, alpha: 1)
            availabilityLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "available", comment: "").localiz()
        } else {
            availabilityLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            availabilityLabel.text = "Unavailable"
        }
    }

}
