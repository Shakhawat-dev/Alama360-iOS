//
//  BankRowTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class BankRowTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblIBANNumber: UILabel!
    @IBOutlet weak var btnEditBank: UIButton!
    @IBOutlet weak var btnDeleteBank: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
