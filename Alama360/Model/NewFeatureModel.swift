//
//  NewFeatureModel.swift
//  Alama360
//
//  Created by Alama360 on 16/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NewFeatureModel {
    
    var id: String = ""
    var col1: String = ""
    var icon: String = ""
    
    init() {
        
    }
    
    init(json: JSON) {
        
        // print("FEature array is: \(json)")
        
            id = json["id"].stringValue
            col1 = json["col1"].stringValue
            icon = json["icon"].stringValue

        //        print("ekhane col1 paise \(col1_array)")
    }
    
}
