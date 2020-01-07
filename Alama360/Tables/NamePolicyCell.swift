//
//  NamePolicyCell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class NamePolicyCell: UITableViewCell {

    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var districtName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
