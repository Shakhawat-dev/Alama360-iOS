//
//  DistrictModel.swift
//  Alama360
//
//  Created by Alama360 on 18/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DistrictModel {
    
    var id: String = ""
    var name: String = ""
    var countryid: String = ""
    var city_id: String = ""
    
    init() {
        
    }
    
    init(json: JSON) {

        id = json["id"].stringValue
        name = json["name"].stringValue
        city_id = json["city_id"].stringValue
        countryid = json["countryid"].stringValue
    }
    
}
