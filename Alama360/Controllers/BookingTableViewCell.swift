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
    
    @IBOutlet weak var featureImageOne: UIImageView!
    @IBOutlet weak var featureImageTwo: UIImageView!
    @IBOutlet weak var featureImageThree: UIImageView!
    
    @IBOutlet weak var featureLabelOne: UILabel!
    @IBOutlet weak var featureLabelTwo: UILabel!
    @IBOutlet weak var featureLabelThree: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        propertyRowSlideShow.contentScaleMode = .scaleAspectFill
        propertyRowSlideShow.slideshowInterval = 0.05
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
