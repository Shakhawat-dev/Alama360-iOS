//
//  DummyCell.swift
//  Alama360
//
//  Created by Alama360 on 29/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class DummyCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
