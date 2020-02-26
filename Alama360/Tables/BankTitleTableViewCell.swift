//
//  BankTitleTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class BankTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBankNameTitle: UILabel!
    @IBOutlet weak var lblAccountNumberTitle: UILabel!
    @IBOutlet weak var lblIBANTitle: UILabel!
    @IBOutlet weak var lblMeasuresTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
