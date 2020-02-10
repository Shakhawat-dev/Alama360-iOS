//
//  DateAvailabilityTitleTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 11/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class DateAvailabilityTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var availabilityTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "date", comment: "").localiz()
        priceTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "price", comment: "").localiz()
        availabilityTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "availablity", comment: "").localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
