//
//  TotalPriceTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 14/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class TotalPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var tpContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tpContainerView.layer.cornerRadius = 8
        tpContainerView.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        tpContainerView.layer.shadowRadius = 8
        tpContainerView.layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        totalPriceLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "total_price", comment: "").localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues(price: [RentalPriceModel]) {
        var total: Int = 0
        for i in price {
            total += Int(i.price!)!
        }

        priceLbl.text = ": " + LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "").localiz() + " \(total)"
    }

}
