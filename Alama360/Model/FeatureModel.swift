//
//  FeatureModel.swift
//  Alama360
//
//  Created by Alama360 on 26/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FeatureModel {
    
    var id_array = [String]()
    var col1_array = [String]()
    var icon_array = [String]()
    
    init() {
        
    }
    
    init(json: JSON) {
        
        // print("FEature array is: \(json)")
        
        for i in json.arrayValue{
            
            var id: String = ""
            var col1: String = ""
            var icon: String = ""
            
            id = i["id"].stringValue
            col1 = i["col1"].stringValue
            icon = i["icon"].stringValue
            
            id_array.append(id)
            col1_array.append(col1)
            icon_array.append(icon)
            
        }
        
        //        print("ekhane col1 paise \(col1_array)")
    }
    
}

