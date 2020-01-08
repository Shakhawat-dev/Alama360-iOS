//
//  NamePolicyCell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class NamePolicyCell: UITableViewCell {

    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var districtName: UILabel!
    @IBOutlet weak var pNameView: UIView!
    @IBOutlet weak var pPolicyView: UIView!
    @IBOutlet weak var timeViews: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pNameView.layer.borderWidth = 1
        pNameView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pPolicyView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
