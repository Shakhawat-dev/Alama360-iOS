//
//  ReservationModel.swift
//  Alama360
//
//  Created by Alama360 on 09/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ReservationModel {
    var slug: String?
    var thumbnail: String?
    var latitude: String?
    var longitude: String?
    var title: String?
    var address: String?
    var daily_price: String?
    var total_cost: String?
    var check_in_date: String?
    var check_out_date: String?
    var created_at: String?
    
    init() {
        
    }
    
    init(json: JSON?) {
    
    self.slug = json?["slug"].stringValue
    self.thumbnail = json?["thumbnail"].stringValue
    self.latitude = json?["latitude"].stringValue
    self.longitude = json?["longitude"].stringValue
    self.title = json?["title"].stringValue
    self.address = json?["address"].stringValue
    self.daily_price = json?["daily_price"].stringValue
    self.total_cost = json?["total_cost"].stringValue
    self.check_in_date = json?["check_in_date"].stringValue
    self.check_out_date = json?["check_out_date"].stringValue
    self.created_at = json?["created_at"].stringValue
 
        
    }

}

