//
//  RentalPriceModel.swift
//  Alama360
//
//  Created by Alama360 on 12/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RentalPriceModel {
    var id: String?
    var property_id: String?
    var rentdate: String?
    var price: String?
    var availabity: String?
    
    init() {
        
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.property_id = json["property_id"].stringValue
        self.rentdate = json["rentdate"].stringValue
        self.price = json["price"].stringValue
        self.availabity = json["availabity"].stringValue
    }
}
