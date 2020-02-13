//
//  CountryModel.swift
//  Alama360
//
//  Created by Alama360 on 18/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CountryModel {
    
    var id: String = ""
    var name: String = ""
    
    init() {
        
    }
    
    init(json: JSON) {

        id = json["id"].stringValue
        name = json["name"].stringValue
    }
    
}
