//
//  CheckInAndOutTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 01/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import iOSDropDown

class CheckInAndOutTableViewCell: UITableViewCell {

    @IBOutlet var lblCheckTimes: [UILabel]!
    @IBOutlet var _checkTimes: [UITextField]!
    @IBOutlet weak var btnNextOne: UIButton!
    @IBOutlet weak var checkInStart: DropDown!
    @IBOutlet weak var checkInEnd: DropDown!
    @IBOutlet weak var checkOutEnd: DropDown!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTimes(time: [TimeModel]) {
        var times = [String]()
        for i in time {
            times.append(i.col1)
        }
        
        checkInStart.optionArray = times
        checkInEnd.optionArray = times
        checkOutEnd.optionArray = times
    }

}
