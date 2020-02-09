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
    var man_section_price: String?
    var woman_section_price: String?
    var refundable: String?
    var refundable_day_before: String?
    var minimum_reservation: String?
    var status: String?
    var allDay: Int?
    var check_in_time: String?
    var check_out_time: String?
    
    init() {
        
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.property_id = json["property_id"].stringValue
        self.rentdate = json["rentdate"].stringValue
        self.price = json["price"].stringValue
        self.availabity = json["availabity"].stringValue
        self.man_section_price = json["man_section_price"].stringValue
        self.woman_section_price = json["woman_section_price"].stringValue
        self.refundable = json["refundable"].stringValue
        self.refundable_day_before = json["refundable_day_before"].stringValue
        self.minimum_reservation = json["minimum_reservation"].stringValue
        self.status = json["status"].stringValue
        self.allDay = json["allDay"].intValue
        self.check_in_time = json["check_in_time"].stringValue
        self.check_out_time = json["check_out_time"].stringValue
        
    }
}
