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
        
        viewHeaderContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewHeaderContainer.layer.borderWidth = 1
        viewHeaderContainer.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
