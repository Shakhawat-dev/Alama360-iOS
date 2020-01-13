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
    
    @IBOutlet weak var lblPolicy: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblStartTimeValue: UILabel!
    @IBOutlet weak var lblExitTime: UILabel!
    @IBOutlet weak var lblExitTimeValue: UILabel!
    @IBOutlet weak var lblSection: UILabel!
    @IBOutlet weak var lblManWomen: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pNameView.layer.borderWidth = 1
        pNameView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pPolicyView.layer.cornerRadius = 12
        
        // For language change
        setLocalization()
    }
    
    func setLocalization() {
        lblPolicy.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "policy", comment: "").localiz()
        lblStartTime.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "start_time_lvl", comment: "").localiz()
        lblStartTimeValue.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "start_time", comment: "").localiz()
        lblExitTime.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "exit_time_lvl", comment: "").localiz()
        lblExitTimeValue.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "exit_time", comment: "").localiz()
        lblSection.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "section", comment: "").localiz()
        lblManWomen.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "man_women", comment: "").localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
