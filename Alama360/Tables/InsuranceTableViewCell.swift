//
//  InsuranceTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class InsuranceTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblCheckTitle: UILabel!
    @IBOutlet weak var lblHInsuranceAmountTile: UILabel!
    @IBOutlet weak var _InsuranceAmount: UITextField!
    @IBOutlet weak var lblOtherConditions: UILabel!
    @IBOutlet weak var _otherConditions: UITextField!
    @IBOutlet weak var lblAdditionalTerms: UILabel!
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
