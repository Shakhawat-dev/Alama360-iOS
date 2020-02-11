//
//  RDdatePriceTitleTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class RDdatePriceTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var actionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "date", comment: "").localiz()
        priceLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "price", comment: "").localiz()
        actionLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "action", comment: "").localiz()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
