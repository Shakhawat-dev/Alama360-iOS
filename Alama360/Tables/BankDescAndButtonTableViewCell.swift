//
//  BankDescAndButtonTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class BankDescAndButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBankDesc: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
