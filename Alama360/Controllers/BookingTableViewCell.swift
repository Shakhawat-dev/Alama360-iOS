//
//  BookingTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 24/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import ImageSlideshow

class BookingTableViewCell: UITableViewCell {
    @IBOutlet weak var propertyRowSlideShow: ImageSlideshow!
    @IBOutlet weak var rowTitle: UILabel!
    @IBOutlet weak var rowCityName: UILabel!
    @IBOutlet weak var rowDayPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
