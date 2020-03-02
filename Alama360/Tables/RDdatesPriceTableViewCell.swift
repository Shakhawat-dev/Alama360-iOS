//
//  RDdatesPriceTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

protocol PriceCellDelegate {
    func didTapDelBtn(index: Int)
}

class RDdatesPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var datePriceContainerView: UIView!
    
    var delegate: PriceCellDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        datePriceContainerView.layer.cornerRadius = 8
        datePriceContainerView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        datePriceContainerView.layer.borderWidth = 1
        datePriceContainerView.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        datePriceContainerView.layer.shadowRadius = 8
        datePriceContainerView.layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteBtnTapped(_ sender: Any) {
        delegate?.didTapDelBtn(index: index!.row)
    }
    
    func setPrices(rentalPrices: RentalPriceModel) {
        
        if rentalPrices.availabity == "1" {
            dateLbl.text = rentalPrices.rentdate
            priceLbl.text = rentalPrices.price
        }

    }

}
