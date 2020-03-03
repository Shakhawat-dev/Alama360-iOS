//
//  BankCategoryModel.swift
//  Alama360
//
//  Created by Alama360 on 28/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CategoryModel {
    
    var id: String = ""
    var col1: String = ""

    
    init() {
        
    }
    
    init(json: JSON) {

        id = json["id"].stringValue
        col1 = json["col1"].stringValue

    }
    
}
