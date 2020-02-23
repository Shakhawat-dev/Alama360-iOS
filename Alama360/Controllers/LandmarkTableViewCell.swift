//
//  LandmarkTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 04/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class LandmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var landmarkName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
