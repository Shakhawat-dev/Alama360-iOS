//
//  OwnerSettingHeaderCell.swift
//  Alama360
//
//  Created by Alama360 on 03/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class OwnerSettingHeaderCell: UITableViewCell {

    @IBOutlet weak var viewHeaderContainer: UIView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
