//
//  MapModel.swift
//  Alama360
//
//  Created by Alama360 on 21/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MapModel {
    var id: String?
    var latitude: Double?
    var longitude: Double?
    var search_keywords: String?
    var thumbnail: String?
    var title: String?
    var address: String?
    var short_des: String?
    var price: String?
    var no_roomcaption: String?
    var no_bathroomcaption: String?
    
    init() {
        
    }
    
    init(json: JSON?) {
        
        self.id = json?["id"].stringValue
        self.latitude = json?["latitude"].doubleValue
        self.longitude = json?["longitude"].doubleValue
        self.search_keywords = json?["search_keywords"].stringValue
        self.thumbnail = json?["thumbnail"].stringValue
        self.title = json?["title"].stringValue
        self.address = json?["address"].stringValue
        self.short_des = json?["short_des"].stringValue
        self.price = json?["price"].stringValue
        self.no_roomcaption = json?["no_roomcaption"].stringValue
        self.no_bathroomcaption = json?["no_bathroomcaption"].stringValue
        
        
    }
}
