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
    @IBOutlet var btncheckbox: [UIButton]!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func resetButtonStates() {
        for button in btncheckbox {
            button.isSelected = false
        }
    }

    @IBAction func freeBtnTapped(_ sender: UIButton) {
        let isAlreadySelected = sender.isSelected == true
        
        resetButtonStates()
        
        if !isAlreadySelected {
               sender.isSelected = true
           } else {
               // Do Nothing since as per your case if you selected the already selected button it should change to disable right, so the resetButtonStates() will do that.
           }
    }
}
