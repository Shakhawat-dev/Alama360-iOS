//
//  BankRowTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

protocol BankDelegate {
    func bEditBtnTapped(index: IndexPath)
    func bDeleteBtnTapped(index: IndexPath)
}

class BankRowTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblIBANNumber: UILabel!
    @IBOutlet weak var btnEditBank: UIButton!
    @IBOutlet weak var btnDeleteBank: UIButton!
    
    var delegate: BankDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBanks(bank: BankModel) {
        lblBankName.text = bank.bankname?.col1
        lblAccountNumber.text = bank.account_no
        lblIBANNumber.text = bank.iban_no
    }
    @IBAction func editBtnTapped(_ sender: Any) {
        delegate?.bEditBtnTapped(index: index!)
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        delegate?.bDeleteBtnTapped(index: index!)
    }
    
}
