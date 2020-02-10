//
//  RefundPolicyTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class RefundPolicyTableViewCell: UITableViewCell {

    @IBOutlet weak var refundContainerView: UIView!
    @IBOutlet weak var refundTitleLbl: UILabel!
    @IBOutlet weak var refundDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        refundContainerView.layer.cornerRadius = 8
        refundContainerView.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        refundContainerView.layer.shadowRadius = 8
        refundContainerView.layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        refundTitleLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "lvl_policy", comment: "").localiz()
        refundDescLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "lvl_policy_details", comment: "").localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
