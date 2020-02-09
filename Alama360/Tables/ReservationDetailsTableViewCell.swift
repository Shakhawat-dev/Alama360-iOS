//
//  ReservationDetailsTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class ReservationDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var propertyThumb: UIImageView!
    @IBOutlet weak var propertyTitle: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPropertyInfo(thumb: String, title: String, city: String, dist: String, man: Int, women: Int) {
        propertyTitle.text = title
        cityLbl.text = city
        districtLbl.text = dist
        
        if man == 1 && women == 2 {
            sectionLbl.text = "Section: Man - Women"
        } else if man == 1 && women == 0 {
            sectionLbl.text = "Section: Man"
        } else if man == 0 && women == 2 {
            sectionLbl.text = "Section: Women"
        } else {
            sectionLbl.text = "Section: --- -----"
        }
    }

}
