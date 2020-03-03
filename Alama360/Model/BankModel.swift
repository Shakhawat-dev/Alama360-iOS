//
//  BankModel.swift
//  Alama360
//
//  Created by Alama360 on 08/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BankModel {
    
    var id: String = ""
    var bank_id: String = ""
    var account_holder_name: String = ""
    var account_no: String = ""
    var iban_no: String = ""
    var bankname: CategoryModel?
    
    
    init() {
        
    }
    
    init(json: JSON) {
        
        id = json["id"].stringValue
        bank_id = json["bank_id"].stringValue
        account_holder_name = json["account_holder_name"].stringValue
        account_no = json["account_no"].stringValue
        iban_no = json["iban_no"].stringValue
        
        let bank = json["bankname"]
        
        let new = CategoryModel(json: JSON(bank))
        self.bankname = new
        
    }
    
}
