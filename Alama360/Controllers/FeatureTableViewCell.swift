//
//  FeatureTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 03/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var featureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        overrideUserInterfaceStyle = .light //For light mode
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
