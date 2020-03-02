//
//  AddButtonTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

protocol AddNewDelegate {
    func addNewBtnTapped(index: IndexPath)
}

class AddButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAddNew: CustomBtnGreen!
    
    var delegate: AddNewDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addNewTapped(_ sender: Any) {
        delegate?.addNewBtnTapped(index: index!)
    }
    
}
