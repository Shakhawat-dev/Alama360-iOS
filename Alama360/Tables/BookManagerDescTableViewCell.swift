//
//  BookManagerDescTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class BookManagerDescTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTheOwner: UILabel!
    @IBOutlet weak var lblOwnerDesc: UILabel!
    @IBOutlet weak var llblReservationManager: UILabel!
    @IBOutlet weak var lblReservationManagerDesc: UILabel!
    @IBOutlet weak var btnNextOne: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
