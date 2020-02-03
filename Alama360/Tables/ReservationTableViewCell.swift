//
//  ReservationTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 09/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {
    @IBOutlet weak var propertyTitle: UILabel!
    @IBOutlet weak var fAddress: UILabel!
    @IBOutlet weak var pAddress: UILabel!
    @IBOutlet weak var fDailyPrice: UILabel!
    @IBOutlet weak var pDailyPrice: UILabel!
    @IBOutlet weak var fTotalPrice: UILabel!
    @IBOutlet weak var pTotalPrice: UILabel!
    @IBOutlet weak var fCheckDate: UILabel!
    @IBOutlet weak var pCheckDate: UILabel!
    @IBOutlet weak var fCheckOutDate: UILabel!
    @IBOutlet weak var pCheckOutDate: UILabel!
    @IBOutlet weak var fBookingDate: UILabel!
    @IBOutlet weak var pBookingDate: UILabel!
    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var cellContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        cellContainer.layer.cornerRadius = 12
        cellContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellContainer.layer.shadowOpacity = 0.3
//        cellContainer.layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        // Configure the view for the selected state
    }
    
    func setValues(reserveData: ReservationModel) {
        propertyTitle.text = reserveData.title
        pAddress.text = reserveData.address
        pDailyPrice.text = reserveData.daily_price
        pTotalPrice.text = reserveData.total_cost
        pCheckDate.text = reserveData.check_in_date
        pCheckOutDate.text = reserveData.check_out_date
        pBookingDate.text = reserveData.created_at
    }

}
