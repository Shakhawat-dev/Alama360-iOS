//
//  BookingModel.swift
//  Alama360
//
//  Created by Alama360 on 26/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BookingModel {
    var id: String?
    var property_type: String?
    var latitude: String?
    var longitude: String?
    var search_keywords: String?
    var thumbnail: String?
    var no_roomcaption: String?
    var no_bathroomcaption: String?
    var tour: String?
    var dayprice: String?
    var title: String?
    var short_des: String?
    var address: String?
    var cityname: String?
    var districtname: String?
    var favorite_info: String?
    var evalnumber: String?
    var photos: Photos?
    var property_dailyfeature: FeatureModel?
    
    
    init() {
        
    }
    
    init(json: JSON?) {
        
        self.id = json?["id"].stringValue
        self.property_type = json?["property_type"].stringValue
        self.latitude = json?["latitude"].stringValue
        self.longitude = json?["longitude"].stringValue
        self.search_keywords = json?["search_keywords"].stringValue
        self.thumbnail = json?["thumbnail"].stringValue
        self.no_roomcaption = json?["no_roomcaption"].stringValue
        self.no_bathroomcaption = json?["no_bathroomcaption"].stringValue
        self.tour = json?["tour"].stringValue
        self.dayprice = json?["dayprice"].stringValue
        self.title = json?["title"].stringValue
        self.short_des = json?["short_des"].stringValue
        self.address = json?["address"].stringValue
        self.cityname = json?["cityname"].stringValue
        self.districtname = json?["districtname"].stringValue
        self.favorite_info = json?["favorite_info"].stringValue
        self.evalnumber = json?["evalnumber"].stringValue
        
        if let value = json?["photos"].arrayValue {
            
//            print("Eta photo response: \(value)")
//            data[0].photos[0].picture
            let new = Photos(json: JSON(value))
            self.photos = new
            
        }
        
        if let value = json?["property_dailyfeature"].arrayValue {
            
            let new = FeatureModel(json: JSON(value))
            self.property_dailyfeature = new
            
        }

    }
    
}

struct Photos {
    var picture = [String?]()
    
    init(json: JSON) {
        
        for i in json.arrayValue{
            var value: String?
            
                value = i["picture"].stringValue
        
            picture.append(value)
            
        }
        
//        print("Picture array: \(picture)")
        
        
        
//        print("ekhane pic paise \(picture)")
    }
}
