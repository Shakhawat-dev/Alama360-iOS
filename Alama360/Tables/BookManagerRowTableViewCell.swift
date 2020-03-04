//
//  BookManagerRowTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

protocol ManagerDelegate {
    func editBtnTapped(index: IndexPath)
    func deleteBtnTapped(index: IndexPath)
    func smsSwitchOn(index: IndexPath)
    func smsSwitchOff(index: IndexPath)
}

class BookManagerRowTableViewCell: UITableViewCell {

    @IBOutlet weak var lblManagerName: UILabel!
    @IBOutlet weak var lblManagerNumber: UILabel!
    @IBOutlet weak var lblManagerSMSswitch: UISwitch!
    @IBOutlet weak var btnManagerEdit: UIButton!
    @IBOutlet weak var BtnManagerDelete: UIButton!
    
    var delegate: ManagerDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setManagers(managers: ClientManagerModel) {
        lblManagerName.text = managers.manager_firstname + " " + managers.manager_lastname
        lblManagerNumber.text = managers.manager_mobile
        
        if managers.manager_sms_status == "1" {
            lblManagerSMSswitch.isOn = true
        } else {
            lblManagerSMSswitch.isOn = false
        }
        
    }
    @IBAction func editBtnTapped(_ sender: Any) {
        delegate?.editBtnTapped(index: index!)
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        delegate?.deleteBtnTapped(index: index!)
    }
    
    @IBAction func smsSwitchStateChanged(_ sender: UISwitch) {
        if sender.isOn {
            delegate?.smsSwitchOn(index: index!)
        } else {
            delegate?.smsSwitchOff(index: index!)
        }
    }
    
    
}
