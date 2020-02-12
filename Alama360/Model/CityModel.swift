//
//  CityModel.swift
//  Alama360
//
//  Created by Alama360 on 18/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CityModel {
    
    var id: String = ""
    var name: String = ""
    var countryid: String = ""
    var stateid: String = ""
    
    init() {
        
    }
    
    init(json: JSON) {

        id = json["id"].stringValue
        name = json["name"].stringValue
        stateid = json["stateid"].stringValue
        countryid = json["countryid"].stringValue
    }
    
}
