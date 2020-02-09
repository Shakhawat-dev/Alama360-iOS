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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
