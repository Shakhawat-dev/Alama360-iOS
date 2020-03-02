//
//  TimeModel.swift
//  Alama360
//
//  Created by Alama360 on 07/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TimeModel {
    
    var id: String = ""
    var col1: String = ""

    
    init() {
        
    }
    
    init(json: JSON) {

        id = json["id"].stringValue
        col1 = json["col1"].stringValue

    }
    
}

