//
//  CancelationReturnTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class CancelationReturnTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCancellationPolicyTile: UILabel!
    @IBOutlet var btnCheck: [UIButton]!
    @IBOutlet var lblCheckTitle: [UILabel]!
    @IBOutlet var lblCancellationDetails: [UILabel]!
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
